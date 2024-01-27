class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.url,
  });
  final String id;
  final String password;
  final String email;
  final String username;
  final String url;

  factory UserModel.fromJSON(Map<String, Object?>? json) => UserModel(
      id: json!['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      url: json['imageurl'] as String);

  @override
  String toString() {
    return 'UserModel(id: $id, password: $password, email: $email, username: $username, url: $url)';
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'password': password,
      'email': email,
      'username': username,
      'imageurl': url,
    };
  }
}
