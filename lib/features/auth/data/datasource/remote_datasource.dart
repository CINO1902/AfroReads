import 'package:afroreads/core/constants/enum.dart';
import 'package:afroreads/core/service/http_service.dart';
import 'package:afroreads/features/auth/data/repository/authrepo.dart';
import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';
import 'package:afroreads/features/auth/domain/model/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasouceImp implements AuthDatasource {
  final HttpService httpService;

  AuthDatasouceImp(this.httpService);

  @override
  Future<List<String>> createacount(CreateAccountModel createAccount) async {
    String result = '';
    String msg = '';
    String token = '';
    List<String> returnvalue = [];

    final response = await httpService.request(
        url: '/createaccount',
        methodrequest: RequestMethod.post,
        data: createAccountModelToJson(createAccount));

    if (response.data['status'] != 'fail') {
      result = response.data['status'];
      msg = response.data['msg'];
      token = response.data['token'];
      returnvalue.add(result);
      returnvalue.add(msg);
      returnvalue.add(token);
    } else {
      result = response.data['status'];
      msg = response.data['msg'];
      returnvalue.add(result);
      returnvalue.add(msg);
    }

    return returnvalue;
  }

  @override
  Future<List<String>> loginaskid(Loginmodel login) async {
    String result = '';
    String msg = '';
    String token = '';
    List<String> returnvalue = [];

    final response = await httpService.request(
        url: '/loginparent',
        methodrequest: RequestMethod.post,
        data: loginmodelToJson(login));

    if (response.data['status'] != 'fail') {
      result = response.data['status'];
      msg = response.data['msg'];
      token = response.data['token'];
      returnvalue.add(result);
      returnvalue.add(msg);
      returnvalue.add(token);
    } else {
      result = response.data['status'];
      msg = response.data['msg'];
      returnvalue.add(result);
      returnvalue.add(msg);
    }

    return returnvalue;
  }

  @override
  Future<List<String>> loginasparent(login) async {
    String result = '';
    String msg = '';
    String token = '';
    List<String> returnvalue = [];

    final response = await httpService.request(
        url: '/loginparent',
        methodrequest: RequestMethod.post,
        data: loginmodelToJson(login));

    if (response.data['success'] != 'false') {
      result = response.data['success'];
      msg = response.data['msg'];
      token = response.data['token'];
      final pref = await SharedPreferences.getInstance();
      pref.setString('tokenlogforparent', token);
      returnvalue.add(result);
      returnvalue.add(msg);
      returnvalue.add(token);
    } else {
      result = response.data['success'];
      msg = response.data['msg'];
      returnvalue.add(result);
      returnvalue.add(msg);
    }

    return returnvalue;
  }

  @override
  Future<List<List>> fetchparent() async {
    List<List> returnvalue = [];
    final pref = await SharedPreferences.getInstance();
    final parenttoken = pref.getString('tokenlogforparent');
   
    httpService.header = {'authorization': 'Bearer $parenttoken'};
    final response = await httpService.request(
      url: '/fetchparentprofile',
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
