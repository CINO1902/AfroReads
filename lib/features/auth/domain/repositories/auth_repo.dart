import 'dart:developer';

import 'package:afroreads/features/auth/data/repository/authrepo.dart';
import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';
import 'package:afroreads/features/auth/domain/model/login.dart';

abstract class AuthReposity {
  Future<List<String>> createacount(CreateAccountModel createaccount);
  Future<List<String>> loginaskid(Loginmodel login);
  Future<List<String>> loginasparent(Loginmodel login);
}

class AuthRepositoryImp implements AuthReposity {
  final AuthDatasource authDatasource;

  AuthRepositoryImp(this.authDatasource);

  @override
  Future<List<String>> createacount(createaccount) async {
    List<String> returnresponse = [];
    try {
      returnresponse = await authDatasource.createacount(createaccount);
    } catch (e) {
      log(e.toString());
    }
    return returnresponse;
  }

  @override
  Future<List<String>> loginaskid(login) async {
    List<String> returnresponse = [];
    try {
      returnresponse = await authDatasource.loginaskid(login);
    } catch (e) {
      log(e.toString());
    }
    return returnresponse;
  }

  @override
  Future<List<String>> loginasparent(login) async {
    List<String> returnresponse = [];
    try {
      returnresponse = await authDatasource.loginasparent(login);
    } catch (e) {
      if (e.toString().contains('Request')) {
        returnresponse.add('1');
      } else if (e.toString().contains('Unexpected')) {
        returnresponse.add('2');
      } else {
        returnresponse.add('3');
      }
      //print(NetworkException(e as NetworkExceptionType).type);
      log(e.toString());
    }
    return returnresponse;
  }
}
