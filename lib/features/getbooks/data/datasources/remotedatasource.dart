import 'package:afroreads/core/constants/enum.dart';
import 'package:afroreads/core/service/http_service.dart';
import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';

class GetbookDatasourceImp implements GetbookDatasource {
  final HttpService httpService;
  GetbookDatasourceImp(this.httpService);
  @override
  Future<List<List>> getbook(page, limit) async {
    List<List> returnvalue = [];
    final response = await httpService.request(
      url: '/call_books?page=$page&limit=$limit',
      methodrequest: RequestMethod.post,
    );

    if (response.data['status'] == 'success') {
      final errorvalue = [];
      final responsedata = [];
      responsedata.add(response.data['notific']);
      errorvalue.add(false);
      returnvalue.add(errorvalue);
      returnvalue.add(responsedata);
    } else {
      final errorvalue = [];
      errorvalue.add(false);
      returnvalue.add(errorvalue);
      returnvalue.add([]);
    }
    print(returnvalue);
    return returnvalue;
  }

  @override
  Future<List<List>> callbookdetails(id) {
    // TODO: implement callbookdetails
    throw UnimplementedError();
  }
}
