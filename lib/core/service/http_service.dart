import 'package:afroreads/core/constants/enum.dart';
import 'package:dio/dio.dart';


abstract class HttpService {
  set header(Map<String, dynamic> header);
 
  Future<Map<String, dynamic>> formdata({
    required String key,
    required String path,
    String? name,
  });
  Future<Response> request({
    required String url,
    required RequestMethod methodrequest,
    Map<String, dynamic>? params,
      CancelToken cancelToken,
    dynamic data,
  });
}
