class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.userName,
  });
  final String id;
  final String password;
  final String email;
  final String userName;

  factory UserModel.fromJSON(Map<String, Object?>? json) => UserModel(
      id: json!['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      userName: json['username'] as String);

  Map<String, Object> toJSON() => {
        'id': id,
        'username': userName,
        'password': password,
        'email': email,
      };

  @override
  String toString() {
    return 'User(id: $id, password: $password, email: $email, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.password == password &&
        other.email == email &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ password.hashCode ^ email.hashCode ^ userName.hashCode;
  }
}
