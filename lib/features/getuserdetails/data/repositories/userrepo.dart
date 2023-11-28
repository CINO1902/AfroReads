import 'package:afroreads/features/getuserdetails/domain/entities/Timechange.dart';

import '../../domain/entities/Restrictionmode.dart';

abstract class UserDataSource {
  Future<List<String>> Validateusername(username);

  Future<List<String>> CreatekidAcount(createaccount);
  Future<List<List>> FetchProfile();
  Future<List<List>> FetchKidProfile();
  Future<List<List>> FetchpublisherProfile();
  Future<List> ChangeRestrictionAge(RestrictMode restrict);
  Future<List> ChangeUnsuitableGenres(RestrictMode restric);
  Future<List> ChangeReadingLevel(RestrictMode restric);
  Future<List> changeCustomTime(TimeModel time);
}
