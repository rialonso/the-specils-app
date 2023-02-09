class UserDataLogged {
  String email;

  UserDataLogged({
    required this.email,
  });
  factory UserDataLogged.fromJson(Map<String, dynamic> json) => UserDataLogged(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}