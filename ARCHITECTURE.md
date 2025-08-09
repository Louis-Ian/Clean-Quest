# CleanQuest Architecture

## 1) Layers & Folders

Feature-centric under `lib/features/<feature>/`:

* **domain/** → entities (plain data), value objects, repository **interfaces**, optionally *services/use cases*
* **data/** → repository **implementations**, data sources (Firestore/HTTP), mappers
* **presentation/**

  * **viewmodels/** → Riverpod `Notifier`/`AsyncNotifier` (or `StateNotifier`)
  * **views/** → widgets/screens (no business logic)

Data flows **down** (view → vm → service → repo), state flows **up** (immutable models / `AsyncValue`).

> **Provider usage policy:** Riverpod for app state. `provider`/`ChangeNotifier` only for trivial, widget-local state or 3rd-party interop.

---

## 2) Example Flow (Welcome / Create Family)

`WelcomeScreen` (View) → `welcomeViewModelProvider` (ViewModel) → *(optional)* `FamilyService` (business rules) → `FamilyRepository` (interface) → `FirestoreFamilyRepository` (IO).
**Navigation** happens in the **View** reacting to ViewModel state, never inside repos/services/VMs.

---

## 3) Providers & State Conventions (Riverpod)

* **Stateless deps** (repos/services): `Provider<T>`
* **Feature state**: prefer `AsyncNotifier`/`Notifier` (or `StateNotifier`)
* Read deps with `ref.read(...)` inside `build()`/constructor; use `late final` if caching
* Expose **intent methods** in VMs (`createFamily`, `joinFamily`, etc.)
* UI watches with `ref.watch(...)` and renders by `AsyncValue` or immutable state

**Example:**

```dart
final familyRepositoryProvider = Provider<FamilyRepository>((_) => throw UnimplementedError());

final familyServiceProvider = Provider<FamilyService>((ref) {
  return FamilyService(ref.read(familyRepositoryProvider));
});

class WelcomeVm extends AsyncNotifier<WelcomeState> {
  @override
  Future<WelcomeState> build() async => const WelcomeState.initial();

  Future<void> createFamily(String name) async {
    state = const AsyncLoading();
    final service = ref.read(familyServiceProvider);
    final result = await AsyncValue.guard(() => service.createFamily(name));
    state = result.whenData((fam) => WelcomeState.success(fam));
  }
}
```

---

## 4) Repositories & Services (Boundaries)

* **Repositories**: the *only* place that touches Firestore/HTTP/SDKs.
* **Services (optional)**: validation, cross-repo orchestration, code generation, permission checks. **No IO** except via repos.

---

## 5) Firebase & Emulators

* Initialize Firebase in `main()` once
* Use emulators in dev:

  * Auth: `useAuthEmulator('localhost', 9099)`
  * Firestore: `useFirestoreEmulator('localhost', 8080)`
* **Testing:** prefer **fakes/mocks** and provider overrides; avoid network calls in unit tests

---

## 6) Testing Conventions

* Unit test **services** and **viewmodels**
* Override repo providers with fakes/mocks
* Keep widget tests lean (wiring/smoke tests)

---

## 7) Feature Recipe

1. `domain/` → entity + repo interface (+ optional service/use cases)
2. `data/` → repo impl + datasource + mappers
3. `presentation/viewmodels/` → Riverpod VM
4. `presentation/views/` → screens/widgets
5. `test/` → service + VM tests with provider overrides

---

## 8) Firestore Patterns

* **Do NOT store `DateTime` as ISO strings** — use **Firestore `Timestamp`**
* Map with `withConverter` or explicit mappers
* Centralize collection refs/datasource helpers; avoid scattering raw collection names
* All queries live in **repos** only

**Example converter:**

```dart
collection.withConverter<Family>(
  fromFirestore: (snap, _) => Family.fromMap(snap.data()!..['id']=snap.id),
  toFirestore: (fam, _) => fam.toMap(),
);
```

---

## 9) Build / Run / Analyze

```bash
flutter pub get
flutter run
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs # Optional: Riverpod codegen
```

---

## 10) Naming & Style

* Interfaces: `<Entity>Repository` (in **domain**)
* Implementations: `Firestore<Entity>Repository` (in **data**)
* Services/use cases: `<Entity>Service` or `<Verb><Entity>UseCase` (in **domain**)
* ViewModels: `<Feature>ViewModel` (provider: `<feature>ViewModelProvider`)
* Immutable models with `copyWith`
* Use design-system widgets; no ad-hoc styling in VMs

---

## 11) What Not To Do

* No Firebase/Firestore/HTTP in **views**, **viewmodels**, or **services**
* No navigation inside repos/services/VMs
* No mutable public model fields
* No heavy async in widget `build()`
* Don't duplicate collection strings everywhere

---

## 12) Tiny Skeleton (Chore Feature)

```dart
features/chore/
  domain/
    chore.dart
    chore_repository.dart
    chore_service.dart          # only if rules/orchestration exist
  data/
    firestore_chore_repository.dart
    chore_datasource.dart
    chore_mappers.dart
  presentation/
    viewmodels/chore_viewmodel.dart
    views/chore_screen.dart
test/features/chore/...
```

---

## Quick "When to Add a Service?" Checklist

* Multiple repo calls must be coordinated → **Service**
* Non-trivial validation/permission rules → **Service**
* Code/token generation (e.g., family invite codes) → **Service**
* Pure pass-through to a single repo → **No Service** (VM → repo)
