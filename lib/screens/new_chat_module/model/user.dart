class UserModel {
  final String uid;
  final String image;
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
    required this.image,
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
      image: json['image'] ?? 'https://via.placeholder.com/150',
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'image': image,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'lastActive': lastActive,
      'isOnline': isOnline,
    };
  }
}
