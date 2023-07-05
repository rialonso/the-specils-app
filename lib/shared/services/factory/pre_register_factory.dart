class PreRegisterFactory {
  String email;
  String password;
  String account_type;

  PreRegisterFactory({
    required this.email,
    required this.password,
    this.account_type = "special"
  });
  factory PreRegisterFactory.fromJson(Map<String, dynamic> json) => PreRegisterFactory(
    email: json["email"],
    password: json["password"],
    account_type: json['account_type']
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "account_type": account_type,
  };
}