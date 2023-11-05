import 'package:afroreads/features/getbooks/domain/entities/getbookpromodel.dart';
import 'package:afroreads/features/search/domain/repositories/searchrepo.dart';
import 'package:flutter/material.dart';

class Searchpro extends ChangeNotifier {
  final SearchRepository searchRepository;
  Searchpro(this.searchRepository);
  bool error = false;
  bool loading = true;
  String errormsg = '';
  List<dynamic> searchdelagate = [];
  List<Pagnitedbook> bookdetailslibrary = [];
  Future<List<dynamic>> getsearch(query) async {
    loading = true;
    final response = await searchRepository.getsearchquery(query);
    if (response.contains('1')) {
      error = true;
      errormsg = 'Request Timed Out';
    } else if (response.contains('2')) {
      error = true;
      errormsg = 'It seems you are out of network';
    } else if (response.contains('3')) {
      error = true;
      errormsg = 'Something went wrong';
    } else {
      searchdelagate = response;
    }
    return response;
  }

  Future<List<Pagnitedbook>> getsearchresult(query) async {
    loading = true;
    final response = await searchRepository.getresult(query);

    if (response.contains('1')) {
      error = true;
      errormsg = 'Request Timed Out';
    } else if (response.contains('2')) {
      error = true;
      errormsg = 'It seems you are out of network';
    } else if (response.contains('3')) {
      error = true;
      errormsg = 'Something went wrong';
    } else {
      final decodedbookdetails = Notific.fromJson(response[1][0]);
      bookdetailslibrary = decodedbookdetails.pagnitedbooks;
      print(bookdetailslibrary);
    }
    return bookdetailslibrary;
  }
}
