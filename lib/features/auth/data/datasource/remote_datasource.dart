import 'package:afroreads/core/constants/enum.dart';
import 'package:afroreads/core/service/http_service.dart';
import 'package:afroreads/features/auth/data/repository/authrepo.dart';
import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';

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
  List<String> login() {
    // TODO: implement login
    throw UnimplementedError();
  }
}
