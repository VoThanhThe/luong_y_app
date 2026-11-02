class AuthUser {
  const AuthUser({
    required this.id,
    required this.username,
    required this.fullName,
    this.avatar,
    this.email,
    this.role,
  });
  final String id;
  final String username;
  final String fullName;
  final String? avatar;
  final String? email;
  final String? role;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: '${json['id'] ?? ''}',
    username: '${json['username'] ?? ''}',
    fullName: '${json['fullName'] ?? ''}',
    avatar: json['avatar'] as String?,
    email: json['email'] as String?,
    role: json['role'] as String?,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'fullName': fullName,
    'avatar': avatar,
    'email': email,
    'role': role,
  };
}

class AuthSession {
  const AuthSession({required this.token, required this.user});
  final String token;
  final AuthUser user;
}
