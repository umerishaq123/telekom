class UserModel {
  final String uid;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String confirmPassword;
  final DateTime lastActive;
  final bool isOnline;

  UserModel({
    required this.uid,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.lastActive,
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      lastActive: json['lastActive'] != null ? DateTime.parse(json['lastActive']) : DateTime.now(),
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'lastActive': lastActive.toIso8601String(),
      'isOnline': isOnline,
    };
  }
}
