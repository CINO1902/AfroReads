import 'dart:developer';
import 'dart:io';

import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';

abstract class Getbookrepository {
  Future<File> getbook( );
}

class getbookrepositoryimp implements Getbookrepository {
  final GetbookDatasource getbookDatasource;

  getbookrepositoryimp(this.getbookDatasource);

  @override
  Future<File> getbook( ) async {
    File returnvalue  = File('file.txt');
    try {
      returnvalue = await getbookDatasource.getbook( );
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }
}
