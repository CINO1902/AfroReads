import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';

abstract class AuthDatasource {
  Future<List<String>> createacount(CreateAccountModel createaccount);
  List<String> login();
}
