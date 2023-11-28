import 'dart:developer';

import 'package:afroreads/features/getuserdetails/data/repositories/userrepo.dart';
import 'package:afroreads/features/getuserdetails/domain/entities/Timechange.dart';

import '../entities/Restrictionmode.dart';

abstract class UserDatarepository {
  Future<List<String>> Validateusername(username);
  Future<List<String>> CreatekidAcount(createaccount);
  Future<List<List>> FetchProfile();
  Future<List<List>> FetchKidProfile();
  Future<List<List>> FetchpublisherProfile();
  Future<List> ChangeRestrictionAge(RestrictMode restrict);
  Future<List> ChangeUnsuitableGenres(RestrictMode restrict);
  Future<List> ChangeReadingLevel(RestrictMode restric);
  Future<List> changeCustomTime(TimeModel time);
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

  @override
  Future<List<List>> FetchKidProfile() async {
    List<List> returnvalue = [];
    try {
      returnvalue = await userDataSource.FetchKidProfile();
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

  @override
  Future<List<List>> FetchpublisherProfile() async {
    List<List> returnvalue = [];
    try {
      returnvalue = await userDataSource.FetchpublisherProfile();
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

  @override
  Future<List> ChangeRestrictionAge(RestrictMode restrict) async {
    List returnvalue = [];
    try {
      returnvalue = await userDataSource.ChangeRestrictionAge(restrict);
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

  @override
  Future<List> ChangeUnsuitableGenres(RestrictMode restrict) async {
    List returnvalue = [];
    try {
      returnvalue = await userDataSource.ChangeUnsuitableGenres(restrict);
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

  @override
  Future<List> ChangeReadingLevel(RestrictMode restric) async {
    List returnvalue = [];
    try {
      returnvalue = await userDataSource.ChangeReadingLevel(restric);
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

  @override
  Future<List> changeCustomTime(TimeModel time) async {
    List returnvalue = [];
    try {
      returnvalue = await userDataSource.changeCustomTime(time);
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
