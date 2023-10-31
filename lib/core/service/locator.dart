import 'package:afroreads/features/auth/data/datasource/remote_datasource.dart';
import 'package:afroreads/features/auth/data/repository/authrepo.dart';
import 'package:afroreads/features/auth/domain/repositories/auth_repo.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:afroreads/features/getbooks/data/datasources/remotedatasource.dart';
import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';
import 'package:afroreads/features/getbooks/domain/repositories/getbook_repo.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'dio_service.dart';
import 'http_service.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator
    ..registerLazySingleton<AuthDatasouceImp>(() => AuthDatasouceImp(locator()))
    ..registerLazySingleton<AuthDatasource>(() => AuthDatasouceImp(locator()))
    ..registerLazySingleton<AuthReposity>(() => AuthRepositoryImp(locator()))
    ..registerLazySingleton(() => AuthPro(locator()))

    //GetBook
    ..registerLazySingleton<GetbookDatasourceImp>(
        () => GetbookDatasourceImp(locator()))
    ..registerLazySingleton<GetbookDatasource>(
        () => GetbookDatasourceImp(locator()))
    ..registerLazySingleton<Getbookrepository>(
        () => getbookrepositoryimp(locator()))
    ..registerLazySingleton(() => GetbookPro(locator()))
    ..registerLazySingleton<HttpService>(() => DioService(locator()))
    //packages
    ..registerLazySingleton(() => Dio());
}
