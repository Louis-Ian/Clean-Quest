import 'package:app/features/welcome/model/family.dart';
import 'package:app/features/welcome/repository/family_repository.dart';

class MockFamilyRepository implements FamilyRepository {
  final Map<String, Family> _families = {};
  final Set<String> _inviteCodes = {};
  int _nextId = 1;

  @override
  Future<Family> createFamily(Family family) async {
    final id = 'family_${_nextId++}';
    final familyWithId = family.copyWith(id: id);
    _families[id] = familyWithId;
    _inviteCodes.add(family.inviteCode);
    return familyWithId;
  }

  @override
  Future<Family?> findFamilyByInviteCode(String inviteCode) async {
    for (final family in _families.values) {
      if (family.inviteCode == inviteCode) {
        return family;
      }
    }
    return null;
  }

  @override
  Future<void> updateFamily(Family family) async {
    if (family.id.isEmpty) {
      throw ArgumentError('Family ID cannot be empty for update operation');
    }
    _families[family.id] = family;
  }

  @override
  Future<Family?> getFamilyByMemberId(String userId) async {
    for (final family in _families.values) {
      if (family.memberIds.contains(userId)) {
        return family;
      }
    }
    return null;
  }

  @override
  Future<bool> inviteCodeExists(String inviteCode) async {
    return _inviteCodes.contains(inviteCode);
  }

  // Test helper methods
  void clear() {
    _families.clear();
    _inviteCodes.clear();
    _nextId = 1;
  }

  void addFamily(Family family) {
    if (family.id.isNotEmpty) {
      _families[family.id] = family;
      _inviteCodes.add(family.inviteCode);
    }
  }
}
