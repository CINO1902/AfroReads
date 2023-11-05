import 'dart:developer';

import 'package:afroreads/features/search/data/repositories/search_repo.dart';

abstract class SearchRepository {
  Future<List<dynamic>> getsearchquery(query);
  Future<List<List>> getresult(query);
}

class SearchRepositoryimp implements SearchRepository {
  final SearchDatasouce searchDatasouce;

  SearchRepositoryimp(this.searchDatasouce);

  @override
  Future<List<dynamic>> getsearchquery(query) async {
    List<dynamic> returnvalue = [];
    try {
      returnvalue = await searchDatasouce.getsearchquery(query);
    } catch (e) {
      if (returnvalue.contains('Server Error')) {
        returnvalue.add('4');
      } else if (e.toString().contains('Request')) {
        returnvalue.add('1');
      } else if (e.toString().contains('Unexpected')) {
        returnvalue.add('2');
      } else {
        returnvalue.add('3');
      }
      log(e.toString());
    }
    return returnvalue;
  }

  @override
  Future<List<List>> getresult(query) async {
    List<List> returnvalue = [];
    try {
      returnvalue = await searchDatasouce.getresult(query);
    } catch (e) {
      log(e.toString());
    }
    return returnvalue;
  }
}
