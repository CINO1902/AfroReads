import 'package:afroreads/features/auth/data/datasource/remote_datasource.dart';
import 'package:afroreads/features/auth/data/repository/authrepo.dart';
import 'package:afroreads/features/auth/domain/repositories/auth_repo.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:afroreads/features/getbooks/data/datasources/remotedatasource.dart';
import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';
import 'package:afroreads/features/getbooks/domain/repositories/getbook_repo.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/features/search/data/datasources/remote_datasource.dart';
import 'package:afroreads/features/search/domain/repositories/searchrepo.dart';
import 'package:afroreads/features/search/presentation/Provider/SearchPro.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/addbooks/data/datasources/remote_datasource.dart';
import '../../features/addbooks/data/repositories/uploadrepo.dart';
import '../../features/addbooks/domain/repositories/uploadbook_repo.dart';
import '../../features/addbooks/presentation/provider/uploadimageprovider.dart';
import '../../features/getuserdetails/data/datasources/remote_datasource.dart';
import '../../features/getuserdetails/data/repositories/userrepo.dart';
import '../../features/getuserdetails/domain/repositories/user_repo.dart';
import '../../features/getuserdetails/presentation/provider/UserDetails.dart';
import '../../features/search/data/repositories/search_repo.dart';
import 'dio_service.dart';
import 'http_service.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator
    ..registerLazySingleton<AuthDatasouceImp>(() => AuthDatasouceImp(locator()))
    ..registerLazySingleton<AuthDatasource>(() => AuthDatasouceImp(locator()))
    ..registerLazySingleton<AuthReposity>(() => AuthRepositoryImp(locator()))
    ..registerLazySingleton(() => AuthPro(locator()))
    //UserDetails
    ..registerLazySingleton<UserDatasourceimp>(
        () => UserDatasourceimp(locator()))
    ..registerLazySingleton<UserDataSource>(() => UserDatasourceimp(locator()))
    ..registerLazySingleton<UserDatarepository>(
        () => UserDatarepositoryimp(locator()))
    ..registerLazySingleton(() => userdetails(locator()))
    //Uploadbook
    ..registerLazySingleton<UploadBookDatasourceImp>(
        () => UploadBookDatasourceImp(locator()))
    ..registerLazySingleton<UploadBookDatasource>(
        () => UploadBookDatasourceImp(locator()))
    ..registerLazySingleton<UploadBookRepo>(() => UploadBookRepoImp(locator()))
    ..registerLazySingleton(() => uploadimageprovider(locator()))
    //GetBook
    ..registerLazySingleton<GetbookDatasourceImp>(
        () => GetbookDatasourceImp(locator()))
    ..registerLazySingleton<GetbookDatasource>(
        () => GetbookDatasourceImp(locator()))
    ..registerLazySingleton<Getbookrepository>(
        () => getbookrepositoryimp(locator()))
    ..registerLazySingleton(() => GetbookPro(locator()))
    ..registerLazySingleton<HttpService>(() => DioService(locator()))
    //search
    ..registerLazySingleton<SearchDatasouceimp>(
        () => SearchDatasouceimp(locator()))
    ..registerLazySingleton<SearchDatasouce>(
        () => SearchDatasouceimp(locator()))
    ..registerLazySingleton<SearchRepository>(
        () => SearchRepositoryimp(locator()))
    ..registerLazySingleton(() => Searchpro(locator()))
    //packages
    ..registerLazySingleton(() => Dio());
}
