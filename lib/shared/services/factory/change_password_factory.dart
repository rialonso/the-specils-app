class ChangePasswordFactory {
  String old_password;
  String password;

  ChangePasswordFactory({
    required this.old_password,
    required this.password
  });
  factory ChangePasswordFactory.fromJson(Map<String, dynamic> json) => ChangePasswordFactory(
    old_password: json["user_id"],
    password: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "old_password": old_password,
    "password": password,
  };
}