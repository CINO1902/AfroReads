
abstract class UserDataSource {
  Future<List<String>> Validateusername(username);
  Future<List<String>> CreatekidAcount(createaccount);
   Future<List<List>> FetchProfile();
}
