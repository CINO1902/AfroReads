import 'dart:developer';
import 'dart:io';

import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';

abstract class getbookrepository {
  Future<File> getbooka();
}

class getbookrepositoryimp implements getbookrepository {
  final GetbookDatasource getbookDatasource;

  getbookrepositoryimp(this.getbookDatasource);

  @override
  Future<File> getbooka() async {
    File returnvalue  = File('file.txt');
    try {
      returnvalue = await getbookDatasource.getbook();
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }
}
