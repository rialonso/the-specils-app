class GoogleSignInFactory {
  String email;
  String login_type;
  String token;

  GoogleSignInFactory({
    required this.email,
    this.login_type = 'google',
    required this.token
  });
  factory GoogleSignInFactory.fromJson(Map<String, dynamic> json) => GoogleSignInFactory(
      email: json["email"],
      login_type: json["login_type"],
      token: json['token']
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "login_type": login_type,
    "token": token,
  };
}