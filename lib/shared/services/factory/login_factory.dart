class LoginFactory {
  String? email;
  String? password;

  LoginFactory({
    required this.email,
    required this.password
  });
  factory LoginFactory.fromJson(Map<String, dynamic> json) => LoginFactory(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}