
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/features/getuserdetails/domain/entities/Restrictionmode.dart';
import 'package:afroreads/features/getuserdetails/domain/entities/Timechange.dart';
import 'package:afroreads/features/getuserdetails/domain/entities/parentkidmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/createkidmodel.dart';
import '../../domain/entities/publishermodel.dart';
import '../../domain/repositories/user_repo.dart';

class userdetails extends ChangeNotifier {
  final UserDatarepository userDatarepository;

  int childdate = DateTime.now().day;
  int childmonth = DateTime.now().month;
  int childyear = DateTime.now().year;
  bool loading = true;
  int childindex = 0;
  bool noterror = false;
  bool kidloading = true;
  bool publoading = false;
  bool loadingrestrict = false;
  bool canreadbooks = false;
  bool restricterror = false;
  String parentlog = '';
  String kidlog = '';
  String publisherlog = '';
  bool validated = false;
  bool profilecreated = false;
  bool childprofileexist = false;
  List clickedbooks = [];
  List<dynamic> decodedresponse = [];
  List<Msg> decoded = [];
  List<Pub> decodedpub = [];
  List<Msg> profileclicklist = [];
  String msg = '';
  DateTime childbirth = DateTime.now();

  userdetails(this.userDatarepository);
  List<Map<String, dynamic>> weeklyHours = [
    {'Monday': 2},
    {'Tuesday': 2},
    {'Wednesday': 4},
    {'Thursday': 2},
    {'Friday': 2},
    {'Saturday': 2},
    {'Sunday': 2},
  ];
  void getdate(dataTime) {
    childbirth = dataTime;
    childdate = childbirth.day;
    childmonth = childbirth.month;
    childyear = childbirth.year;
    notifyListeners();
  }

  void changeweeklyhours(index, day, String value) {
    int newValue = int.parse(value.split('')[0]);
    weeklyHours[index][day] = newValue;
    notifyListeners();
    print(weeklyHours);
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
    childindex = index;
    profileclicklist.clear();
    profileclicklist.add(decoded[index]);
    if (profileclicklist[0].time.isNotEmpty) {
      weeklyHours[0]['Monday'] = profileclicklist[0].time[0].monday;
      weeklyHours[1]['Tuesday'] = profileclicklist[0].time[1].tuesday;
      weeklyHours[2]['Wednesday'] = profileclicklist[0].time[2].wednesday;
      weeklyHours[3]['Thursday'] = profileclicklist[0].time[3].thursday;
      weeklyHours[4]['Friday'] = profileclicklist[0].time[4].friday;
      weeklyHours[5]['Saturday'] = profileclicklist[0].time[5].saturday;
      weeklyHours[6]['Sunday'] = profileclicklist[0].time[6].sunday;
    }

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
    profileclicked(childindex);
    notifyListeners();
  }

  void fetchkidID() async {
    kidloading = true;
    notifyListeners();
    final response = await userDatarepository.FetchKidProfile();
    kidloading = false;
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

  bool canreadbook() {
    bool canreadbookss = false;
    if (decoded[0].allowedBookAge != null) {
      if (int.parse(decoded[0].allowedBookAge!.split('-')[0]) <
          int.parse(clickedbooks[9].split('-')[1])) {
        canreadbookss = true;
      } else {
        canreadbookss = false;
      }
    } else {
      canreadbookss = true;
    }
    return canreadbookss;
  }

  void fetchpublisherprofile() async {
    publoading = true;
    notifyListeners();
    final response = await userDatarepository.FetchpublisherProfile();
    publoading = false;
    if (response[0][0] == '1') {
      decodedresponse = response[1];
      decodedpub = Publisherdetail.fromJson(decodedresponse[0]).pub;
      print(decodedpub[0].name);
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

  Future<void> updaterestrictmode(bool restrict, age) async {
    loadingrestrict = true;
    notifyListeners();
    String getagebracket(age) {
      String agebracket = '';
      if (age == 1) {
        agebracket = '0-8';
      } else if (age == 2) {
        agebracket = '9-13';
      } else if (age == 3) {
        agebracket = '14-16';
      } else if (age == 4) {
        agebracket = 'Any Age';
      }
      return agebracket;
    }

    RestrictMode restric = RestrictMode(
        restrict: restrict,
        age: getagebracket(age),
        username: profileclicklist[0].username);
    final response = await userDatarepository.ChangeRestrictionAge(restric);
    loadingrestrict = false;
    if (response[0][0] == '1') {
      restricterror = false;
      msg = 'Updated';
    } else if (response[0][0] == '2') {
      restricterror = true;
      msg = 'Server Error';
    } else if (response[0][0] == '3') {
      restricterror = true;
      msg = 'Request Timed Outl';
    } else if (response[0][0] == '4') {
      restricterror = true;
      msg = 'Seems there is no network';
    } else if (response[0][0] == '5') {
      restricterror = false;
      msg = 'Something went wrong';
    }
    fetchchildID();
    notifyListeners();
  }

  Future<void> updatereadinglevel(bool restrict, age) async {
    loadingrestrict = true;
    notifyListeners();
    String getagebracket(age) {
      String agebracket = '';
      if (age == 1) {
        agebracket = 'Beginner';
      } else if (age == 2) {
        agebracket = 'Intermediate';
      } else if (age == 3) {
        agebracket = 'Advanced';
      }
      return agebracket;
    }

    RestrictMode restric = RestrictMode(
        restrict: restrict,
        age: getagebracket(age),
        username: profileclicklist[0].username);
    final response = await userDatarepository.ChangeReadingLevel(restric);
    loadingrestrict = false;
    if (response[0][0] == '1') {
      restricterror = false;
      msg = 'Updated';
    } else if (response[0][0] == '2') {
      restricterror = true;
      msg = 'Server Error';
    } else if (response[0][0] == '3') {
      restricterror = true;
      msg = 'Request Timed Outl';
    } else if (response[0][0] == '4') {
      restricterror = true;
      msg = 'Seems there is no network';
    } else if (response[0][0] == '5') {
      restricterror = false;
      msg = 'Something went wrong';
    }
    fetchchildID();
    notifyListeners();
  }

  Future<void> changeunsuitablegenres(bool restrict, List age) async {
    loadingrestrict = true;
    notifyListeners();
    String liststring = '';
    if (age.isNotEmpty) {
      for (var i = 0; i < age.length; i++) {
        liststring = liststring + ',' + age[i];
      }
      liststring = liststring.substring(1);
    }

    RestrictMode restric = RestrictMode(
        restrict: restrict,
        age: liststring,
        username: profileclicklist[0].username);
    final response = await userDatarepository.ChangeUnsuitableGenres(restric);
    loadingrestrict = false;
    if (response[0][0] == '1') {
      restricterror = false;
      msg = 'Updated';
    } else if (response[0][0] == '2') {
      restricterror = true;
      msg = 'Server Error';
    } else if (response[0][0] == '3') {
      restricterror = true;
      msg = 'Request Timed Outl';
    } else if (response[0][0] == '4') {
      restricterror = true;
      msg = 'Seems there is no network';
    } else if (response[0][0] == '5') {
      restricterror = false;
      msg = 'Something went wrong';
    }
    fetchchildID();
    notifyListeners();
  }

  void getloguser() async {
    final pref = await SharedPreferences.getInstance();
    parentlog = pref.getString('tokenlogforparent') ?? '';
    kidlog = pref.getString('tokenlogforkid') ?? '';
    publisherlog = pref.getString('tokenlogforpublisher') ?? '';
  }

  Future<void> changeCustomTime(custom, gentime) async {
    loadingrestrict = true;
    notifyListeners();
    String getagebracket(age) {
      String agebracket = '';
      if (age == 1) {
        agebracket = 'Violent';
      } else if (age == 2) {
        agebracket = 'Horror';
      } else if (age == 3) {
        agebracket = 'Sexual';
      }
      return agebracket;
    }

    TimeModel restric = TimeModel(
        custom: custom,
        time: weeklyHours,
        gentime: gentime,
        username: profileclicklist[0].username);
    final response = await userDatarepository.changeCustomTime(restric);
    loadingrestrict = false;
    if (response[0][0] == '1') {
      restricterror = false;
      msg = 'Updated';
    } else if (response[0][0] == '2') {
      restricterror = true;
      msg = 'Server Error';
    } else if (response[0][0] == '3') {
      restricterror = true;
      msg = 'Request Timed Outl';
    } else if (response[0][0] == '4') {
      restricterror = true;
      msg = 'Seems there is no network';
    } else if (response[0][0] == '5') {
      restricterror = false;
      msg = 'Something went wrong';
    }
    fetchchildID();
    notifyListeners();
  }

  void update(GetbookPro getbookPro) {
    clickedbooks = getbookPro.clickedbooks;
  }
}
