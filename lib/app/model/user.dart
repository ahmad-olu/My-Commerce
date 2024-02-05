class AppWriteDbUser {
  AppWriteDbUser({
    required this.id,
    required this.email,
    required this.isAdmin,
  });

  factory AppWriteDbUser.fromMap(Map<String, dynamic> map) {
    return AppWriteDbUser(
      id: (map[r'$id'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      isAdmin: (map['is_admin'] ?? false) as bool,
    );
  }

  // factory AppWriteDbUser.fromJson(String source) =>
  //     AppWriteDbUser.fromMap(json.decode(source));

  final String id;
  final String email;
  final bool isAdmin;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  // String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'AppWriteDbUser(id: $id, email: $email, isAdmin: $isAdmin)';
}
