import 'package:chatapp/shared/models/base_user.dart';

class UserModel extends AbstractUser {
  const UserModel({
    required super.id,
    required super.email,
    required super.password,
    required super.username,
    required super.url,
  });

  factory UserModel.fromJSON(Map<String, Object?>? json) => UserModel(
      id: json!['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      url: json['imageurl'] as String);

  @override
  Map<String, dynamic> toJSON() => {
        'id': id,
        'password': password,
        'email': email,
        'username': username,
        'imageurl': url,
      };

  @override
  String toString() {
    return 'User extends AbstractUser(id: $id, password: $password, email: $email, username: $username, url: $url)';
  }
}
