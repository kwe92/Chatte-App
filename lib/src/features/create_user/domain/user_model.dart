class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });
  final String id;
  final String password;
  final String email;
  final String username;

  factory UserModel.fromJSON(Map<String, Object?>? json) => UserModel(
      id: json!['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String);

  Map<String, Object> toJSON() => {
        'id': id,
        'username': username,
        'password': password,
        'email': email,
      };

  @override
  String toString() {
    return 'User(id: $id, password: $password, email: $email, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.password == password &&
        other.email == email &&
        other.username == username;
  }

  @override
  int get hashCode {
    return id.hashCode ^ password.hashCode ^ email.hashCode ^ username.hashCode;
  }
}
