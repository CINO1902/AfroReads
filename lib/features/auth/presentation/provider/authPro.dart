import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';
import 'package:afroreads/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter/foundation.dart';

class AuthPro extends ChangeNotifier {
  final AuthReposity authReposity;

  AuthPro(this.authReposity);
  bool loading = false;
  List<String> returnvalue = [];
  String msg = '';
  String status = '';
  Future<void> createaccount(
      fullname, email, password, dateofbirth, securityquestion, answer) async {
    CreateAccountModel createAccount = CreateAccountModel(
        fullname: fullname,
        email: email,
        password: password,
        dateOfBirth: dateofbirth,
        securityQuestion: securityquestion,
        securityAns: answer);
    loading = true;
    returnvalue = await authReposity.createacount(createAccount);
    loading = false;
    msg = returnvalue[1];
    status = returnvalue[0];
  }
}
