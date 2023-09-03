
import 'dart:convert';

CreateAccountModel createAccountModelFromJson(String str) => CreateAccountModel.fromJson(json.decode(str));

String createAccountModelToJson(CreateAccountModel data) => json.encode(data.toJson());

class CreateAccountModel {
    String fullname;
    String email;
    String password;
    String dateOfBirth;
    String securityQuestion;
    String securityAns;

    CreateAccountModel({
        required this.fullname,
        required this.email,
        required this.password,
        required this.dateOfBirth,
        required this.securityQuestion,
        required this.securityAns,
    });

    factory CreateAccountModel.fromJson(Map<String, dynamic> json) => CreateAccountModel(
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        dateOfBirth: json["date_of_birth"],
        securityQuestion: json["Security_Question"],
        securityAns: json["Security_ans"],
    );

    Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "password": password,
        "date_of_birth": dateOfBirth,
        "Security_Question": securityQuestion,
        "Security_ans": securityAns,
    };
}
