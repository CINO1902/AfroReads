import 'dart:developer';
import 'package:afroreads/features/getbooks/data/repositories/getbooksrepo.dart';
import 'package:afroreads/features/getbooks/domain/entities/getReadbooks.dart';

abstract class Getbookrepository {
  Future<List<List>> getbook(page, limit);
  Future<List<List>> callbookdetails(page, id);
  Future<List<List>> callmybooks(page, limit);
  Future<List<List>> ReadBooks(GetReadingBooks booksid);
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

  @override
  Future<List<List>> ReadBooks(GetReadingBooks booksid) async {
    List<List> returnresponse = [];
    try {
      returnresponse = await getbookDatasource.ReadBooks(booksid);
      print(returnresponse);
    } catch (e) {
      if (e.toString().contains('Request')) {
        returnresponse.add(['4']);
      } else if (e.toString().contains('Unexpected')) {
        returnresponse.add(['5']);
      } else {
        returnresponse.add(['6']);
      }
      log(e.toString());
    }
    return returnresponse;
  }
}
