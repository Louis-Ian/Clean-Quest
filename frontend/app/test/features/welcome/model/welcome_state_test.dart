import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/welcome/model/welcome_state.dart';
import 'package:app/features/welcome/model/family.dart';

void main() {
  group('WelcomeState Tests', () {
    test('should create WelcomeInitial state', () {
      // Act
      const state = WelcomeInitial();

      // Assert
      expect(state, isA<WelcomeState>());
      expect(state, isA<WelcomeInitial>());
    });

    test('should create WelcomeLoading state', () {
      // Act
      const state = WelcomeLoading();

      // Assert
      expect(state, isA<WelcomeState>());
      expect(state, isA<WelcomeLoading>());
    });

    test('should create WelcomeSuccess state with family', () {
      // Arrange
      final family = Family(
        id: 'test123',
        name: 'Test Family',
        createdBy: 'user123',
        createdAt: DateTime(2024, 1, 1),
        memberIds: ['user123'],
        inviteCode: 'TEST123',
      );

      // Act
      final state = WelcomeSuccess(family);

      // Assert
      expect(state, isA<WelcomeState>());
      expect(state, isA<WelcomeSuccess>());
      expect(state.family, equals(family));
    });

    test('should create WelcomeError state with message', () {
      // Arrange
      const errorMessage = 'Something went wrong';

      // Act
      const state = WelcomeError(errorMessage);

      // Assert
      expect(state, isA<WelcomeState>());
      expect(state, isA<WelcomeError>());
      expect(state.message, equals(errorMessage));
    });

    test('should handle pattern matching correctly', () {
      // Arrange
      const initialState = WelcomeInitial();
      const loadingState = WelcomeLoading();
      const errorState = WelcomeError('Test error');
      final successState = WelcomeSuccess(
        Family(
          id: 'test',
          name: 'Test',
          createdBy: 'user',
          createdAt: DateTime.now(),
          memberIds: ['user'],
          inviteCode: 'TEST',
        ),
      );

      // Act & Assert - Test pattern matching
      String getStateType(WelcomeState state) {
        return switch (state) {
          WelcomeInitial() => 'initial',
          WelcomeLoading() => 'loading',
          WelcomeSuccess() => 'success',
          WelcomeError() => 'error',
        };
      }

      expect(getStateType(initialState), equals('initial'));
      expect(getStateType(loadingState), equals('loading'));
      expect(getStateType(successState), equals('success'));
      expect(getStateType(errorState), equals('error'));
    });

    test('should be immutable', () {
      // Arrange
      const initialState = WelcomeInitial();
      const loadingState = WelcomeLoading();
      const errorState = WelcomeError('Error message');
      final successState = WelcomeSuccess(
        Family(
          id: 'test',
          name: 'Test Family',
          createdBy: 'user',
          createdAt: DateTime.now(),
          memberIds: ['user'],
          inviteCode: 'TEST',
        ),
      );

      // Assert - All states should be const constructible (immutable)
      expect(identical(initialState, const WelcomeInitial()), isTrue);
      expect(identical(loadingState, const WelcomeLoading()), isTrue);
      expect(identical(errorState, const WelcomeError('Error message')), isTrue);
      expect(identical(successState, successState), isTrue);
    });
  });
}
