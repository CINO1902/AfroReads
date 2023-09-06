// import 'dart:io';

// import 'package:afroreads/core/constants/enum.dart';
// import 'package:afroreads/core/service/http_service.dart';
// import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';
// import 'package:http/http.dart' as http;

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// class GetbookDatasourceImp implements GetbookDatasource {
//   final HttpService httpService;
//   GetbookDatasourceImp(this.httpService);
//   @override
//  static Future<File> loadNetwork(String url) async {
//     final response = await http.get(url);
//     final bytes = response.bodyBytes;

//     return _storeFile(url, bytes);
//   }

//   static Future<File> _storeFile(String url, List<int> bytes) async {
//     final filename = basename(url);
//     final dir = await getApplicationDocumentsDirectory();

//     final file = File('${dir.path}/$filename');
//     await file.writeAsBytes(bytes, flush: true);
//     return file;
//   }
  
//   @override
//   Future<File> getbook(String url) async{
//     final response = await http.get(url);
//     final bytes = response.bodyBytes;

//     return _storeFile(url, bytes);
//   }
// }
