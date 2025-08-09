import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/family.dart';
import '../repository/family_repository.dart';

class FamilyService {
  final FamilyRepository _repository;

  FamilyService({required FamilyRepository repository}) : _repository = repository;

  FirebaseAuth get _auth => FirebaseAuth.instance;

  /// Creates a new family and returns the created family
  Future<Family> createFamily(String familyName) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User must be authenticated to create a family');
    }

    final inviteCode = await _generateUniqueInviteCode();
    final family = Family.create(name: familyName, createdBy: user.uid, inviteCode: inviteCode);

    return await _repository.createFamily(family);
  }

  /// Joins a family using an invite code
  Future<Family> joinFamily(String inviteCode) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User must be authenticated to join a family');
    }

    final family = await _repository.findFamilyByInviteCode(inviteCode);
    if (family == null) {
      throw Exception('Invalid invite code');
    }

    if (family.memberIds.contains(user.uid)) {
      throw Exception('You are already a member of this family');
    }

    // Add user to family members
    final updatedFamily = family.copyWith(memberIds: [...family.memberIds, user.uid]);

    await _repository.updateFamily(updatedFamily);
    return updatedFamily;
  }

  /// Gets the family for the current user
  Future<Family?> getCurrentUserFamily() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    return await _repository.getFamilyByMemberId(user.uid);
  }

  /// Generates a random 6-character invite code
  String generateInviteCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  /// Generates a unique invite code by checking against existing codes
  Future<String> _generateUniqueInviteCode() async {
    String code;
    bool exists;

    do {
      code = generateInviteCode();
      exists = await _repository.inviteCodeExists(code);
    } while (exists);

    return code;
  }
}
