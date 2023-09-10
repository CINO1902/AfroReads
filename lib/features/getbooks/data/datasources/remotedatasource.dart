import 'dart:io';

import 'package:afroreads/core/constants/enum.dart';
import 'package:afroreads/core/service/http_service.dart';
import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GetbookDatasourceImp implements GetbookDatasource {
  final HttpService httpService;
  GetbookDatasourceImp(this.httpService);
  @override
  Future<File> getbook() async {
  final  url = Uri.https(
        'https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwid4Nyi95WBAxVjgYQIHa3iAEkQFnoECBEQAQ&url=https%3A%2F%2Fwww.opportunitiesforyouth.org%2Fwp-content%2Fuploads%2F2021%2F04%2FAtomic_Habits_by_James_Clear-1.pdf&usg=AOvVaw1jer-3Bl9AybLrAmPXwHmZ&opi=89978449');
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    return _storeFile(url as String, bytes);
  }
//  @override
//  static Future<File> loadNetwork(String url) async {
//     final response = await http.get(url);
//     final bytes = response.bodyBytes;

//     return _storeFile(url, bytes);
//   }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
