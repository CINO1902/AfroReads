
import 'dart:convert';

Loginmodel loginmodelFromJson(String str) => Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
    String email;
    String password;

    Loginmodel({
        required this.email,
        required this.password,
    });

    factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
