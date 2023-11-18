import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';
import 'package:afroreads/features/auth/domain/model/login.dart';
import 'package:afroreads/features/auth/domain/model/parentmodel.dart';
import 'package:afroreads/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter/foundation.dart';

class AuthPro extends ChangeNotifier {
  final AuthReposity authReposity;

  AuthPro(this.authReposity);
  bool loading = false;
  bool loginerror = false;
  bool loadingloginparent = false;
  bool parentloading = false;
  List<dynamic> decodedresponse = [];
  String errormsg = '';
  List<Msg> decoded = [];
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

  Future<void> loginkid(email, password) async {
    loginerror = false;
    Loginmodel login = Loginmodel(
      email: email,
      password: password,
    );
    loadingloginparent = true;
    returnvalue = await authReposity.loginaskid(login);
    loadingloginparent = false;

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

  Future<void> loginpub(email, password) async {
    loginerror = false;
    Loginmodel login = Loginmodel(
      email: email,
      password: password,
    );
    loadingloginparent = true;
    returnvalue = await authReposity.loginaspublisher(login);
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

  void fetchparentID() async {
    parentloading = true;

    final response = await authReposity.fetchparent();
    parentloading = false;
    if (response[0][0] == '1') {
      decodedresponse = response[1];
      decoded = Parentdetails.fromJson(decodedresponse[0]).msg;

      //  childprofileexist = true;
    } else if (response[0][0] == '2') {
      // childprofileexist = false;
    } else if (response[0][0] == '3') {
      // childprofileexist = false;
    } else if (response[0][0] == '4') {
      //  childprofileexist = false;
    } else if (response[0][0] == '5') {
      // childprofileexist = false;
    }
    notifyListeners();
  }
}
