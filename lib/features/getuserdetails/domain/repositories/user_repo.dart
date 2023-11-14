import 'dart:developer';

import 'package:afroreads/features/getuserdetails/data/repositories/userrepo.dart';

abstract class UserDatarepository {
  Future<List<String>> Validateusername(username);
  Future<List<String>> CreatekidAcount(createaccount);
  Future<List<List>> FetchProfile();
}

class UserDatarepositoryimp implements UserDatarepository {
  final UserDataSource userDataSource;

  UserDatarepositoryimp(this.userDataSource);
  @override
  Future<List<String>> CreatekidAcount(createaccount) async {
    List<String> returnvalue = [];
    try {
      returnvalue = await userDataSource.CreatekidAcount(createaccount);
    } catch (e) {
      if (e.toString().contains('Request')) {
        returnvalue.add('4');
      } else if (e.toString().contains('Unexpected')) {
        returnvalue.add('5');
      } else {
        returnvalue.add('6');
      }
    }
    return returnvalue;
  }

  @override
  Future<List<String>> Validateusername(username) async {
    List<String> returnvalue = [];
    try {
      returnvalue = await userDataSource.Validateusername(username);
    } catch (e) {
      log(e.toString());
      if (e.toString().contains('Request')) {
        returnvalue.add('3');
      } else if (e.toString().contains('Unexpected')) {
        returnvalue.add('4');
      } else {
        returnvalue.add('5');
      }
    }
    return returnvalue;
  }

  @override
  Future<List<List>> FetchProfile() async {
    List<List> returnvalue = [];
    try {
      returnvalue = await userDataSource.FetchProfile();
    } catch (e) {
      log(e.toString());
      if (e.toString().contains('Request')) {
        final errorvalue = ['3'];
        returnvalue.add(errorvalue);
      } else if (e.toString().contains('Unexpected')) {
        final errorvalue = ['4'];
        returnvalue.add(errorvalue);
      } else {
        final errorvalue = ['5'];
        returnvalue.add(errorvalue);
      }
    }
    return returnvalue;
  }
}
