import 'dart:developer';
import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';

abstract class Getbookrepository {
  Future<List<List>> getbook(page, limit);
  Future<List<List>> callbookdetails(page, id);
  Future<List<List>> callmybooks(page, limit);
}

class getbookrepositoryimp implements Getbookrepository {
  final GetbookDatasource getbookDatasource;

  getbookrepositoryimp(this.getbookDatasource);

  @override
  Future<List<List>> getbook(page, limit) async {
    List<List> returnvalue = [];
    try {
      returnvalue = await getbookDatasource.getbook(page, limit);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }

  @override
  Future<List<List>> callbookdetails(page, id) async {
    List<List> returnvalue = [];
    try {
      returnvalue = await getbookDatasource.getbook(page, id);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }

  @override
  Future<List<List>> callmybooks(page, limit) async {
    List<List> returnvalue = [];
    try {
      returnvalue = await getbookDatasource.callmybooks(page, limit);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }
}
