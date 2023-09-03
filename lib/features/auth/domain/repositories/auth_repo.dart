import 'dart:developer';

import 'package:afroreads/features/auth/data/repository/authrepo.dart';
import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';

abstract class AuthReposity {
  Future<List<String>> createacount(CreateAccountModel createaccount);
  List<String> login();
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
  List<String> login() {
    // TODO: implement login
    throw UnimplementedError();
  }
}
