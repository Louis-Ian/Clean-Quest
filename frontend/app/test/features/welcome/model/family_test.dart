import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/welcome/model/family.dart';

void main() {
  group('Family Model Tests', () {
    test('should create a family with required parameters', () {
      // Arrange
      const id = 'family123';
      const name = 'Smith Family';
      const createdBy = 'user123';
      final createdAt = DateTime(2024, 1, 1);
      const memberIds = ['user123', 'user456'];
      const inviteCode = 'ABC123';

      // Act
      final family = Family(
        id: id,
        name: name,
        createdBy: createdBy,
        createdAt: createdAt,
        memberIds: memberIds,
        inviteCode: inviteCode,
      );

      // Assert
      expect(family.id, equals(id));
      expect(family.name, equals(name));
      expect(family.createdBy, equals(createdBy));
      expect(family.createdAt, equals(createdAt));
      expect(family.memberIds, equals(memberIds));
      expect(family.inviteCode, equals(inviteCode));
    });

    test('should create a family using factory method', () {
      // Arrange
      const name = 'Johnson Family';
      const createdBy = 'user789';
      const inviteCode = 'XYZ789';

      // Act
      final family = Family.create(name: name, createdBy: createdBy, inviteCode: inviteCode);

      // Assert
      expect(family.id, equals('')); // Should be empty initially
      expect(family.name, equals(name));
      expect(family.createdBy, equals(createdBy));
      expect(family.inviteCode, equals(inviteCode));
      expect(family.memberIds, contains(createdBy));
      expect(family.memberIds.length, equals(1));
      expect(family.createdAt, isA<DateTime>());
    });

    test('should convert family to map correctly', () {
      // Arrange
      const id = 'family456';
      const name = 'Brown Family';
      const createdBy = 'user101';
      final createdAt = DateTime(2024, 1, 15);
      const memberIds = ['user101', 'user102'];
      const inviteCode = 'DEF456';

      final family = Family(
        id: id,
        name: name,
        createdBy: createdBy,
        createdAt: createdAt,
        memberIds: memberIds,
        inviteCode: inviteCode,
      );

      // Act
      final map = family.toMap();

      // Assert
      expect(map['name'], equals(name));
      expect(map['createdBy'], equals(createdBy));
      expect(map['createdAt'], equals(createdAt.toIso8601String()));
      expect(map['memberIds'], equals(memberIds));
      expect(map['inviteCode'], equals(inviteCode));
      expect(map.length, equals(5)); // Should have exactly 5 fields
    });

    test('should create family from map correctly', () {
      // Arrange
      const id = 'family789';
      const name = 'Wilson Family';
      const createdBy = 'user202';
      final createdAt = DateTime(2024, 2, 1);
      const memberIds = ['user202', 'user203', 'user204'];
      const inviteCode = 'GHI789';

      final map = {
        'name': name,
        'createdBy': createdBy,
        'createdAt': createdAt.toIso8601String(),
        'memberIds': memberIds,
        'inviteCode': inviteCode,
      };

      // Act
      final family = Family.fromMap(id, map);

      // Assert
      expect(family.id, equals(id));
      expect(family.name, equals(name));
      expect(family.createdBy, equals(createdBy));
      expect(family.createdAt, equals(createdAt));
      expect(family.memberIds, equals(memberIds));
      expect(family.inviteCode, equals(inviteCode));
    });

    test('should handle missing fields in fromMap with defaults', () {
      // Arrange
      const id = 'family999';
      final map = <String, dynamic>{};

      // Act
      final family = Family.fromMap(id, map);

      // Assert
      expect(family.id, equals(id));
      expect(family.name, equals(''));
      expect(family.createdBy, equals(''));
      expect(family.memberIds, isEmpty);
      expect(family.inviteCode, equals(''));
      expect(family.createdAt, isA<DateTime>());
    });

    test('should create copy with updated fields', () {
      // Arrange
      final originalFamily = Family(
        id: 'original123',
        name: 'Original Family',
        createdBy: 'user1',
        createdAt: DateTime(2024, 1, 1),
        memberIds: ['user1'],
        inviteCode: 'ORIGINAL',
      );

      // Act
      final updatedFamily = originalFamily.copyWith(
        name: 'Updated Family',
        memberIds: ['user1', 'user2'],
      );

      // Assert
      expect(updatedFamily.id, equals(originalFamily.id));
      expect(updatedFamily.name, equals('Updated Family'));
      expect(updatedFamily.createdBy, equals(originalFamily.createdBy));
      expect(updatedFamily.createdAt, equals(originalFamily.createdAt));
      expect(updatedFamily.memberIds, equals(['user1', 'user2']));
      expect(updatedFamily.inviteCode, equals(originalFamily.inviteCode));
    });

    test('should create copy with all fields updated', () {
      // Arrange
      final originalFamily = Family(
        id: 'original456',
        name: 'Original Family',
        createdBy: 'user1',
        createdAt: DateTime(2024, 1, 1),
        memberIds: ['user1'],
        inviteCode: 'ORIGINAL',
      );

      final newCreatedAt = DateTime(2024, 2, 1);

      // Act
      final updatedFamily = originalFamily.copyWith(
        id: 'new789',
        name: 'New Family',
        createdBy: 'user2',
        createdAt: newCreatedAt,
        memberIds: ['user2', 'user3'],
        inviteCode: 'NEW123',
      );

      // Assert
      expect(updatedFamily.id, equals('new789'));
      expect(updatedFamily.name, equals('New Family'));
      expect(updatedFamily.createdBy, equals('user2'));
      expect(updatedFamily.createdAt, equals(newCreatedAt));
      expect(updatedFamily.memberIds, equals(['user2', 'user3']));
      expect(updatedFamily.inviteCode, equals('NEW123'));
    });
  });
}
