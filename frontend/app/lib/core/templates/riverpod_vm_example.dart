import 'package:flutter_riverpod/flutter_riverpod.dart';

class Family {
  final String id;
  final String name;
  const Family({required this.id, required this.name});
}

abstract class FamilyRepository {
  Future<Family> createFamily(String name);
  Stream<Family?> watchCurrentFamily();
}

final familyRepositoryProvider = Provider<FamilyRepository>((ref) => throw UnimplementedError());

class FamilyService {
  final FamilyRepository _repo;
  const FamilyService(this._repo);
  Future<Family> createFamily(String name) {
    // validation/rules here (no SDK calls)
    return _repo.createFamily(name.trim());
  }
}

final familyServiceProvider = Provider<FamilyService>(
  (ref) => FamilyService(ref.read(familyRepositoryProvider)),
);

class FamilyState {
  final bool loading;
  final Family? current;
  final String? error;
  const FamilyState({this.loading = false, this.current, this.error});
  FamilyState copyWith({bool? loading, Family? current, String? error}) =>
      FamilyState(loading: loading ?? this.loading, current: current ?? this.current, error: error);
}

class FamilyViewModel extends StateNotifier<FamilyState> {
  FamilyViewModel(this.ref) : super(const FamilyState());

  final Ref ref;

  Future<void> createFamily(String name) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final fam = await ref.read(familyServiceProvider).createFamily(name);
      state = state.copyWith(loading: false, current: fam);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final familyViewModelProvider = StateNotifierProvider<FamilyViewModel, FamilyState>(
  (ref) => FamilyViewModel(ref),
);
