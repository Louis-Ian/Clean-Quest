class Family {
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final List<String> memberIds;
  final String inviteCode;

  Family({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.memberIds,
    required this.inviteCode,
  });

  factory Family.create({
    required String name,
    required String createdBy,
    required String inviteCode,
  }) {
    return Family(
      id: '', // Will be set by Firestore
      name: name,
      createdBy: createdBy,
      createdAt: DateTime.now(),
      memberIds: [createdBy],
      inviteCode: inviteCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'memberIds': memberIds,
      'inviteCode': inviteCode,
    };
  }

  factory Family.fromMap(String id, Map<String, dynamic> map) {
    return Family(
      id: id,
      name: map['name'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      memberIds: List<String>.from(map['memberIds'] ?? []),
      inviteCode: map['inviteCode'] ?? '',
    );
  }

  Family copyWith({
    String? id,
    String? name,
    String? createdBy,
    DateTime? createdAt,
    List<String>? memberIds,
    String? inviteCode,
  }) {
    return Family(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      memberIds: memberIds ?? this.memberIds,
      inviteCode: inviteCode ?? this.inviteCode,
    );
  }
}
