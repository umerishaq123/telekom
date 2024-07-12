// To parse this JSON data, do
//
//     final logout = logoutFromJson(jsonString);

import 'dart:convert';

Logout logoutFromJson(String str) => Logout.fromJson(json.decode(str));

String logoutToJson(Logout data) => json.encode(data.toJson());

class Logout {
    String? message;

    Logout({
        this.message,
    });

    factory Logout.fromJson(Map<String, dynamic> json) => Logout(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
