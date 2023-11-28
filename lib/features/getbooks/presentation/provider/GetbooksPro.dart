import 'package:afroreads/features/getbooks/domain/entities/getbookpromodel.dart';
import 'package:afroreads/features/getbooks/domain/repositories/getbook_repo.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:flutter/material.dart';

class GetbookPro extends ChangeNotifier {
  final Getbookrepository getbookrepository;

  GetbookPro(this.getbookrepository);
  bool error = false;
  bool errorlibrary = false;
  bool mybookerrorerror = false;
  bool loading = true;
  bool loadinglibrary = true;
  String bookurl = '';
  int page = 1;
  int mybookspage = 1;
  bool mybookloading = true;
  bool mybookisloadmore = false;
  bool mybookhasnextpage = true;
  bool isloadmore = false;
  bool hasnextpage = true;
  List<Pagnitedbook> bookdetails = [];
  List<Pagnitedbook> bookdetailslibrary = [];
  List<Pagnitedbook> mybookdetails = [];
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

  void getmybooks() async {
    mybookloading = true;
    final response = await getbookrepository.callmybooks(1, 10);

    mybookloading = false;
    mybookerrorerror = response[0][0];
    final decodedbookdetails = Notific.fromJson(response[1][0]);
    mybookdetails = decodedbookdetails.pagnitedbooks;
    print(mybookdetails);
    final loadmore = decodedbookdetails.next;
    if (loadmore.page == page) {
      mybookhasnextpage = false;
    } else {
      mybookhasnextpage = true;
    }
    notifyListeners();
  }

  void getmybooksmore() async {
    if (mybookhasnextpage == true &&
        mybookisloadmore == false &&
        mybookloading == false) {
      mybookisloadmore = true;
      mybookspage += 1;
      notifyListeners();
      final response = await getbookrepository.callmybooks(mybookspage, 10);
      mybookisloadmore = false;
      mybookloading = false;
      mybookerrorerror = response[0][0];
      final decodedbookdetails = Notific.fromJson(response[1][0]);
      mybookdetails.addAll(decodedbookdetails.pagnitedbooks);
      final loadmore = decodedbookdetails.next;
      if (loadmore.page == mybookspage) {
        mybookhasnextpage = false;
      } else {
        mybookhasnextpage = true;
      }
      notifyListeners();
    }
  }

  void getclickedbook(id, booktitle, authorname, review, norated, link, addedby,
      imageurl, preview, agebracket, genre) {
    clickedbooks.add(id);
    clickedbooks.add(booktitle);
    clickedbooks.add(authorname);
    clickedbooks.add(review);
    clickedbooks.add(norated);
    clickedbooks.add(link);
    clickedbooks.add(addedby);
    clickedbooks.add(imageurl);
    clickedbooks.add(preview);
    clickedbooks.add(agebracket);
    clickedbooks.add(genre);
  }

  void clickbookurl(url) {
    bookurl = url;
  }

  void disposeclickedbook() {
    clickedbooks.clear();
  }
}
