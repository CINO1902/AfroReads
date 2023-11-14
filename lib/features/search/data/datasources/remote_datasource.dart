import 'package:afroreads/core/service/http_service.dart';
import 'package:afroreads/features/search/data/repositories/search_repo.dart';

import '../../../../core/constants/enum.dart';

class SearchDatasouceimp implements SearchDatasouce {
  final HttpService httpService;

  SearchDatasouceimp(this.httpService);
  @override
  Future<List<dynamic>> getsearchquery(query) async {
    List<dynamic> returnvalue = [];
    final response = await httpService.request(
      url: '/searchdelegate?keyword=$query',
      methodrequest: RequestMethod.get,
    );

    if (response.data['status'] == 'success') {
      returnvalue = response.data['notific'];
    } else {
      returnvalue.add('Server Error');
    }

    return returnvalue;
  }

  Future<List<List>> getresult(query) async {
    List<List> returnvalue = [];
    final response = await httpService.request(
      url: '/search?keyword=$query',
      methodrequest: RequestMethod.get,
    );
    print(response);
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

    return returnvalue;
  }
}
