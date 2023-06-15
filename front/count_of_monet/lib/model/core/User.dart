class User {
  String userId;

  String username;

  String email;

  String? token;

  User({
    required this.userId,
    required this.username,
    required this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["id"].toString(),
      username: json["username"].toString(),
      email: json["email"].toString(),
    );
  }

  factory User.empty() {
    return User(
      email: "",
      userId: "",
      username: "",
    );
  }
}
