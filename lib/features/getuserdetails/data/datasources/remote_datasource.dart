import 'package:afroreads/core/constants/enum.dart';
import 'package:afroreads/core/service/http_service.dart';
import 'package:afroreads/features/getuserdetails/data/repositories/userrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/createkidmodel.dart';

class UserDatasourceimp implements UserDataSource {
  final HttpService httpService;
  UserDatasourceimp(this.httpService);

  @override
  Future<List<String>> CreatekidAcount(createaccount) async {
    List<String> returnvalue = [];
    final pref = await SharedPreferences.getInstance();
    final parenttoken = pref.getString('tokenlogforparent');
    httpService.header = {'authorization': 'Bearer $parenttoken'};
    final response = await httpService.request(
        url: '/createkidaccount',
        methodrequest: RequestMethod.post,
        data: createkidprofileToJson(createaccount));
    if (response.data['status'] == '1') {
      returnvalue.add('1');
    } else if (response.data['status'] == '2') {
      returnvalue.add('2');
    } else {
      returnvalue.add('3');
    }
    return returnvalue;
  }

  @override
  Future<List<String>> Validateusername(username) async {
    List<String> returnvalue = [];

    final response = await httpService.request(
      url: '/validateusername?username=$username',
      methodrequest: RequestMethod.post,
    );

    if (response.data['status'] == 'success') {
      final errorvalue = [];

      errorvalue.add(false);
      returnvalue.add('1');
    } else {
      final errorvalue = [];
      errorvalue.add(true);
      returnvalue.add('2');
    }
    return returnvalue;
  }

  @override
  Future<List<List>> FetchProfile() async {
    List<List> returnvalue = [];
    final pref = await SharedPreferences.getInstance();
    final parenttoken = pref.getString('tokenlogforparent');

    //print(parenttoken);
    httpService.header = {'authorization': 'Bearer $parenttoken'};
    final response = await httpService.request(
      url: '/fetchchildprofile',
      methodrequest: RequestMethod.post,
    );
    if (response.data['status'] == '1') {
      final errorvalue = ['1'];
      List value = [];
      value.add(response.data);
      // List valuesent = response.data;
      returnvalue.add(errorvalue);
      returnvalue.add(value);
    } else if (response.data['status'] == '2') {
      final errorvalue = ['2'];

      returnvalue.add(errorvalue);
    } else {
      final errorvalue = ['3'];
      returnvalue.add(errorvalue);
    }
    return returnvalue;
  }

  @override
  Future<List<List>> FetchKidProfile() async {
    List<List> returnvalue = [];
    final pref = await SharedPreferences.getInstance();
    final kidtoken = pref.getString('tokenlogforkid');

    print(kidtoken);
    httpService.header = {'authorization': 'Bearer $kidtoken'};
    final response = await httpService.request(
      url: '/fetchkidprofile',
      methodrequest: RequestMethod.post,
    );
    if (response.data['status'] == '1') {
      final errorvalue = ['1'];
      List value = [];
      value.add(response.data);
      // List valuesent = response.data;
      returnvalue.add(errorvalue);
      returnvalue.add(value);
    } else if (response.data['status'] == '2') {
      final errorvalue = ['2'];

      returnvalue.add(errorvalue);
    } else {
      final errorvalue = ['3'];
      returnvalue.add(errorvalue);
    }
    return returnvalue;
  }
  
  @override
  Future<List<List>> FetchpublisherProfile() async{
    List<List> returnvalue = [];
    final pref = await SharedPreferences.getInstance();
    final pubtoken = pref.getString('tokenlogforpublisher');

    print(pubtoken);
    httpService.header = {'authorization': 'Bearer $pubtoken'};
    final response = await httpService.request(
      url: '/fetchpublisheraccount',
      methodrequest: RequestMethod.post,
    );
    if (response.data['status'] == '1') {
      final errorvalue = ['1'];
      List value = [];
      value.add(response.data);
      // List valuesent = response.data;
      returnvalue.add(errorvalue);
      returnvalue.add(value);
    } else if (response.data['status'] == '2') {
      final errorvalue = ['2'];

      returnvalue.add(errorvalue);
    } else {
      final errorvalue = ['3'];
      returnvalue.add(errorvalue);
    }
    return returnvalue;
  }
}
