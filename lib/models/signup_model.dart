class Telecom {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;

  Telecom({
   required this.username,
   required this.firstName,
   required this.lastName,
   required this.email,
   required this.password,
   required this.confirmPassword,
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
