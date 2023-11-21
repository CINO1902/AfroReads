import 'package:afroreads/features/addbooks/data/repositories/uploadrepo.dart';
import 'package:afroreads/features/addbooks/domain/entities/Uploadmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/service/http_service.dart';

class UploadBookDatasourceImp implements UploadBookDatasource {
  final HttpService httpService;

  UploadBookDatasourceImp(this.httpService);

  @override
  Future<List<String>> uploadbook(Uploadbook uploadbook) async {
    String result = '';
    String msg = '';

    List<String> returnvalue = [];
    final pref = await SharedPreferences.getInstance();
    final pubtoken = pref.getString('tokenlogforpublisher');

    httpService.header = {'authorization': 'Bearer $pubtoken'};
    final response = await httpService.request(
        url: '/uploadbooks',
        methodrequest: RequestMethod.post,
        data: uploadbookToJson(uploadbook));
    print(response.data);
    if (response.data['status'] == '1') {
      result = response.data['status'];
      msg = response.data['msg'];

      returnvalue.add(result);
      returnvalue.add(msg);
    } else {
      result = response.data['status'];
      msg = response.data['msg'];
      returnvalue.add(result);
      returnvalue.add(msg);
    }
    return returnvalue;
  }
}
