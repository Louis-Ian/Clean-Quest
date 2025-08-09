import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/family.dart';
import 'family_repository.dart';

/// Firestore implementation of FamilyRepository
class FirestoreFamilyRepository implements FamilyRepository {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  static const String _collectionName = 'families';

  @override
  Future<Family> createFamily(Family family) async {
    final docRef = await _firestore.collection(_collectionName).add(family.toMap());
    return family.copyWith(id: docRef.id);
  }

  @override
  Future<Family?> findFamilyByInviteCode(String inviteCode) async {
    final querySnapshot = await _firestore
        .collection(_collectionName)
        .where('inviteCode', isEqualTo: inviteCode)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    final doc = querySnapshot.docs.first;
    return Family.fromMap(doc.id, doc.data());
  }

  @override
  Future<void> updateFamily(Family family) async {
    if (family.id.isEmpty) {
      throw ArgumentError('Family ID cannot be empty for update operation');
    }

    await _firestore.collection(_collectionName).doc(family.id).update(family.toMap());
  }

  @override
  Future<Family?> getFamilyByMemberId(String userId) async {
    final querySnapshot = await _firestore
        .collection(_collectionName)
        .where('memberIds', arrayContains: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    final doc = querySnapshot.docs.first;
    return Family.fromMap(doc.id, doc.data());
  }

  @override
  Future<bool> inviteCodeExists(String inviteCode) async {
    final querySnapshot = await _firestore
        .collection(_collectionName)
        .where('inviteCode', isEqualTo: inviteCode)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
