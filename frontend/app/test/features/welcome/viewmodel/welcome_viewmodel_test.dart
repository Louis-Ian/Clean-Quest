import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/welcome/viewmodel/welcome_viewmodel.dart';
import 'package:app/features/welcome/model/welcome_state.dart';
import '../mocks/mock_family_repository.dart';

void main() {
  group('WelcomeViewModel Tests', () {
    late ProviderContainer container;
    late MockFamilyRepository mockRepository;

    setUp(() {
      mockRepository = MockFamilyRepository();
      container = ProviderContainer(
        overrides: [familyRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
      mockRepository.clear();
    });

    test('should have initial state as WelcomeInitial', () {
      // Act
      final state = container.read(welcomeViewModelProvider);

      // Assert
      expect(state, isA<WelcomeInitial>());
    });

    test('should reset state to initial', () {
      // Arrange
      final viewModel = container.read(welcomeViewModelProvider.notifier);

      // Act
      viewModel.resetState();

      // Assert
      final state = container.read(welcomeViewModelProvider);
      expect(state, isA<WelcomeInitial>());
    });
  });
}
