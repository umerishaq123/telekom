class Telecom {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;

  Telecom({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory Telecom.fromJson(Map<String, dynamic> json) => Telecom(
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "confirm_password": confirmPassword,
  };
}
