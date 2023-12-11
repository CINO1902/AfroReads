import 'package:afroreads/features/auth/domain/model/createAccountModel.dart';
import 'package:afroreads/features/auth/domain/model/login.dart';

abstract class  AuthDatasource {
  Future<List<String>> createacount(CreateAccountModel createaccount);
  Future<List<String>> publishercreateacount(CreateAccountModel createaccount);
  Future<List<String>> loginaskid(Loginmodel login);
  Future<List<String>> loginasparent(Loginmodel login);
  Future<List<String>> loginaspublisher(Loginmodel login);
  Future<List<List>> fetchparent();
}
