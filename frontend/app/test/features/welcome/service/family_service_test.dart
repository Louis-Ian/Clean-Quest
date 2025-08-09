import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/welcome/service/family_service.dart';
import '../mocks/mock_family_repository.dart';

void main() {
  group('FamilyService Tests', () {
    late FamilyService familyService;
    late MockFamilyRepository mockRepository;

    setUp(() {
      mockRepository = MockFamilyRepository();
      familyService = FamilyService(repository: mockRepository);
    });

    tearDown(() {
      mockRepository.clear();
    });

    group('generateInviteCode', () {
      test('should generate a 6-character code', () {
        // Act
        final code = familyService.generateInviteCode();

        // Assert
        expect(code.length, equals(6));
        expect(code, matches(RegExp(r'^[A-Z0-9]{6}$')));
      });

      test('should generate unique codes on multiple calls', () {
        // Act
        final codes = List.generate(100, (_) => familyService.generateInviteCode());

        // Assert
        final uniqueCodes = codes.toSet();
        expect(uniqueCodes.length, equals(codes.length));
      });

      test('should only contain uppercase letters and numbers', () {
        // Act
        final code = familyService.generateInviteCode();

        // Assert
        for (final char in code.split('')) {
          expect('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.contains(char), isTrue);
        }
      });
    });

    // Note: Full integration tests for Firebase-dependent methods
    // (createFamily, joinFamily, getCurrentUserFamily) should be run
    // with a live Firebase emulator in a separate integration test suite.
  });
}
