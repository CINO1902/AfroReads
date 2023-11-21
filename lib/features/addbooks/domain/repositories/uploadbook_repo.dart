import 'dart:developer';

import 'package:afroreads/features/addbooks/data/repositories/uploadrepo.dart';
import 'package:afroreads/features/addbooks/domain/entities/Uploadmodel.dart';


abstract class UploadBookRepo {
  Future<List<String>> uploadbook(Uploadbook uploadbook);
}

class UploadBookRepoImp implements UploadBookRepo {
  final UploadBookDatasource uploadBookDatasource;

  UploadBookRepoImp(this.uploadBookDatasource);

  @override
  Future<List<String>> uploadbook(Uploadbook uploadbook) async {
    List<String> returnresponse = [];
    try {
      returnresponse = await uploadBookDatasource.uploadbook(uploadbook);
    } catch (e) {
      if (e.toString().contains('Request')) {
        returnresponse.add('3');
      } else if (e.toString().contains('Unexpected')) {
        returnresponse.add('4');
      } else {
        returnresponse.add('5');
      }
      log(e.toString());
    }
    return returnresponse;
  }
}
