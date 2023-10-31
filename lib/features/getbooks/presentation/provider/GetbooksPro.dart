import 'dart:math';

import 'package:afroreads/features/getbooks/domain/entities/getbookpromodel.dart';
import 'package:afroreads/features/getbooks/domain/repositories/getbook_repo.dart';
import 'package:flutter/material.dart';

class GetbookPro extends ChangeNotifier {
  final Getbookrepository getbookrepository;

  GetbookPro(this.getbookrepository);
  bool error = false;
  bool errorlibrary = false;
  bool loading = true;
  bool loadinglibrary = true;
  String bookurl = '';
  int page = 1;
  bool isloadmore = false;
  bool hasnextpage = true;
  List<Pagnitedbook> bookdetails = [];
  List<Pagnitedbook> bookdetailslibrary = [];
  List clickedbooks = [];
  void getbook() async {
    final response = await getbookrepository.getbook(1, 5);

    loading = false;
    error = response[0][0];
    final decodedbookdetails = Notific.fromJson(response[1][0]);
    bookdetails = decodedbookdetails.pagnitedbooks;
    notifyListeners();
  }

  void getlibrarybooks() async {
    loadinglibrary = true;
    final response = await getbookrepository.getbook(1, 10);

    loadinglibrary = false;
    errorlibrary = response[0][0];
    final decodedbookdetails = Notific.fromJson(response[1][0]);
    bookdetailslibrary = decodedbookdetails.pagnitedbooks;
    final loadmore = decodedbookdetails.next;
    if (loadmore.page == page) {
      hasnextpage = false;
    } else {
      hasnextpage = true;
    }
    notifyListeners();
  }

  void getlibrarybooksmore() async {
    if (hasnextpage == true && isloadmore == false && loadinglibrary == false) {
      isloadmore = true;
      page += 1;
      notifyListeners();
      final response = await getbookrepository.getbook(page, 10);
      isloadmore = false;
      loadinglibrary = false;
      errorlibrary = response[0][0];
      final decodedbookdetails = Notific.fromJson(response[1][0]);
      bookdetailslibrary.addAll(decodedbookdetails.pagnitedbooks);
      final loadmore = decodedbookdetails.next;
      if (loadmore.page == page) {
        hasnextpage = false;
      } else {
        hasnextpage = true;
      }
      notifyListeners();
    }
  }

  void getclickedbook(id, booktitle, authorname, review, norated, link, addedby,
      imageurl, preview) {
    clickedbooks.add(id);
    clickedbooks.add(booktitle);
    clickedbooks.add(authorname);
    clickedbooks.add(review);
    clickedbooks.add(norated);
    clickedbooks.add(link);
    clickedbooks.add(addedby);
    clickedbooks.add(imageurl);
    clickedbooks.add(preview);
  }

  void clickbookurl(url) {
    bookurl = url;
  }

  void disposeclickedbook() {
    clickedbooks.clear();
  }
}
