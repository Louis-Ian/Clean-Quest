import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/welcome_state.dart';
import '../service/family_service.dart';
import '../repository/family_repository.dart';
import '../repository/firestore_family_repository.dart';

final familyRepositoryProvider = Provider<FamilyRepository>((ref) {
  return FirestoreFamilyRepository();
});

final familyServiceProvider = Provider<FamilyService>((ref) {
  final repository = ref.read(familyRepositoryProvider);
  return FamilyService(repository: repository);
});

final welcomeViewModelProvider = NotifierProvider<WelcomeViewModel, WelcomeState>(
  () => WelcomeViewModel(),
);

class WelcomeViewModel extends Notifier<WelcomeState> {
  late final FamilyService _familyService;

  @override
  WelcomeState build() {
    _familyService = ref.read(familyServiceProvider);
    return const WelcomeInitial();
  }

  Future<void> createFamily(String familyName) async {
    state = const WelcomeLoading();

    try {
      final family = await _familyService.createFamily(familyName);
      state = WelcomeSuccess(family);
    } catch (e) {
      state = WelcomeError(e.toString());
    }
  }

  Future<void> joinFamily(String inviteCode) async {
    state = const WelcomeLoading();

    try {
      final family = await _familyService.joinFamily(inviteCode);
      state = WelcomeSuccess(family);
    } catch (e) {
      state = WelcomeError(e.toString());
    }
  }

  void resetState() {
    state = const WelcomeInitial();
  }
}
