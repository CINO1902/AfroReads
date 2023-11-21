import 'package:afroreads/features/getuserdetails/domain/entities/parentkidmodel.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/createkidmodel.dart';
import '../../domain/repositories/user_repo.dart';

class userdetails extends ChangeNotifier {
  final UserDatarepository userDatarepository;

  int childdate = DateTime.now().day;
  int childmonth = DateTime.now().month;
  int childyear = DateTime.now().year;
  bool loading = false;
  bool noterror = false;
  bool validated = false;
  bool profilecreated = false;
  bool childprofileexist = false;

  List<dynamic> decodedresponse = [];
  List<Msg> decoded = [];
  List<Msg> profileclicklist = [];
  String msg = '';
  DateTime childbirth = DateTime.now();

  userdetails(this.userDatarepository);

  void getdate(dataTime) {
    childbirth = dataTime;
    childdate = childbirth.day;
    childmonth = childbirth.month;
    childyear = childbirth.year;
    notifyListeners();
  }

  int calculateage(String dob) {
    int age = 0;
    int day = int.parse(dob.split('-')[0]);
    int month = int.parse(dob.split('-')[1]);
    int year = int.parse(dob.split('-')[2]);
    DateTime date = DateTime.now();
    if (month > date.month) {
      age = (date.year - year) - 1;
    } else if (month < date.month) {
      age = (date.year - year);
    } else if (month == date.month) {
      if (day > date.day) {
        age = (date.year - year) - 1;
      } else if (day <= date.day) {
        age = (date.year - year);
      }
      age = (date.year - year);
    }
    return age;
  }

  void profileclicked(index) {
    profileclicklist.clear();

    profileclicklist.add(decoded[index]);
    calculateage(profileclicklist[0].dateOfBirth);
  }

  void validateusername(username) async {
    loading = true;
    notifyListeners();
    final response = await userDatarepository.Validateusername(username);
    loading = false;
    noterror = false;
    if (response[0] == '1') {
      validated = true;
      msg = 'is available';
    } else if (response[0] == '2') {
      noterror = true;
      validated = false;
      msg = 'is not available';
    } else if (response[0] == '3') {
      validated = false;
      msg = 'Request Timed Out';
    } else if (response[0] == '4') {
      validated = false;
      msg = 'Seems there is no network';
    } else if (response[0] == '5') {
      validated = false;
      msg = 'Something went wrong';
    }
    notifyListeners();
  }

  Future<void> createkidprofile(fullname, username, dob) async {
    Createkidprofile childprofile = Createkidprofile(
      fullname: fullname,
      dateOfBirth: dob,
      username: username,
    );
    loading = true;
    final response = await userDatarepository.CreatekidAcount(childprofile);
    loading = false;
    if (response[0] == '1') {
      profilecreated = true;
      msg = 'is available';
    } else if (response[0] == '2') {
      profilecreated = false;
      msg = 'Username alread exist';
    } else if (response[0] == '3') {
      profilecreated = false;
      msg = 'Server Error';
    } else if (response[0] == '4') {
      profilecreated = false;
      msg = 'Request Timed Outl';
    } else if (response[0] == '5') {
      profilecreated = false;
      msg = 'Seems there is no network';
    } else if (response[0] == '6') {
      profilecreated = false;
      msg = 'Something went wrong';
    }
    fetchchildID();
    notifyListeners();
  }

  void fetchchildID() async {
    loading = true;
    final response = await userDatarepository.FetchProfile();
    loading = false;
    if (response[0][0] == '1') {
      decodedresponse = response[1];
      decoded = Parentkidmodel.fromJson(decodedresponse[0]).msg;
      childprofileexist = true;
    } else if (response[0][0] == '2') {
      childprofileexist = false;
    } else if (response[0][0] == '3') {
      childprofileexist = false;
    } else if (response[0][0] == '4') {
      childprofileexist = false;
    } else if (response[0][0] == '5') {
      childprofileexist = false;
    }
    notifyListeners();
  }
}
