class User {
  const User(
      {required this.id,
      required this.email,
      required this.userName,
      required this.password});
  final String id;
  final String password;
  final String email;
  final String userName;

  @override
  String toString() {
    return 'User(id: $id, password: $password, email: $email, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
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
