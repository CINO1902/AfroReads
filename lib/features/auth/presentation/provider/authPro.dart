import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';
import 'package:afroreads/features/auth/domain/model/login.dart';
import 'package:afroreads/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter/foundation.dart';

class AuthPro extends ChangeNotifier {
  final AuthReposity authReposity;

  AuthPro(this.authReposity);
  bool loading = false;
  bool loginerror = false;
  bool loadingloginparent = false;
  String errormsg = '';
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

  Future<void> login(email, password) async {
    loginerror = false;
    Loginmodel login = Loginmodel(
      email: email,
      password: password,
    );
    loadingloginparent = true;
    returnvalue = await authReposity.loginasparent(login);
    loadingloginparent = false;
    print(returnvalue);
    if (returnvalue.contains('1')) {
      loginerror = true;
      errormsg = 'Request Timed Out';
    } else if (returnvalue.contains('2')) {
      loginerror = true;
      errormsg = 'It seems you are out of network';
    } else if (returnvalue.contains('3')) {
      loginerror = true;
      errormsg = 'Something went wrong';
    } else {
      msg = returnvalue[1];
      status = returnvalue[0];
    }
    notifyListeners();
  }
}
