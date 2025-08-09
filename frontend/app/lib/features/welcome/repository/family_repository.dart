import '../model/family.dart';

/// Abstract repository interface for family data operations
/// This allows for different implementations (Firestore, local storage, API, etc.)
abstract class FamilyRepository {
  /// Creates a new family and returns the created family with generated ID
  Future<Family> createFamily(Family family);

  /// Finds a family by invite code
  Future<Family?> findFamilyByInviteCode(String inviteCode);

  /// Updates an existing family
  Future<void> updateFamily(Family family);

  /// Gets the family that contains the specified user ID
  Future<Family?> getFamilyByMemberId(String userId);

  /// Checks if an invite code already exists
  Future<bool> inviteCodeExists(String inviteCode);
}
