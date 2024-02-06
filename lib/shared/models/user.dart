abstract class User {
  const User({
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

  Map<String, dynamic> toJSON();
}
