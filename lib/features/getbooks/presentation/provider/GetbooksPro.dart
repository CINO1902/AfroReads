import 'package:afroreads/features/getbooks/domain/entities/ReadBookModel.dart';
import 'package:afroreads/features/getbooks/domain/entities/getReadbooks.dart';
import 'package:afroreads/features/getbooks/domain/entities/getbookpromodel.dart';
import 'package:afroreads/features/getbooks/domain/repositories/getbook_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> progress = [];
  String currentcpi = '';
  List<Pagnitedbook> bookdetails = [];
  List<Pagnitedbook> bookdetailslibrary = [];
  List<Pagnitedbook> mybookdetails = [];
  List clickedbooks = [];
  bool readbookerror = false;
  bool loadingReadbook = false;
  List<ReadBook> bookd = [];
  bool existbooks = false;
  String errormsg = '';
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
    clickedbooks.clear();
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

  void savebookprogress(int progressSave, epubcpi) async {
    final pref = await SharedPreferences.getInstance();
    progress
        .removeWhere((element) => element.contains(progressSave.toString()));
    progress.add('${progressSave.toString()}-$epubcpi');
    print(progress);
    getsavedbooks();
    pref.setStringList('progress', progress);
    // print(progress);
  }

  void getsavedbooks() async {
    final pref = await SharedPreferences.getInstance();
    // pref.remove('progress');
    final saveprogress = pref.getStringList('progress');
    progress = saveprogress ?? [];
    if (progress.isNotEmpty) {
      existbooks = true;
    } else {
      print('object');
      existbooks = false;
    }
    print(existbooks);
    notifyListeners();
    // print(saveprogress);
  }

  Future<void> GetReadBook() async {
    readbookerror = false;
    List<String> newBookList = [];
    for (var i = 0; i < progress.length; i++) {
      final addString = progress[i].split('-')[0];
      newBookList.add(addString);
    }
    // print(newBookList);
    GetReadingBooks books = GetReadingBooks(keyword: newBookList);

    loadingReadbook = true;

    final returnvalue = await getbookrepository.ReadBooks(books);
    loadingReadbook = false;
    bookd = GetReadingBooksModel.fromJson(returnvalue[1][0]).readBook;

    bookd.sort((a, b) {
      int indexA = newBookList.indexOf(a.readBookId.toString());
      int indexB = newBookList.indexOf(b.readBookId.toString());
      if (indexA != -1 && indexB != -1) {
        return indexA.compareTo(indexB);
      } else if (indexA != -1) {
        return -1; // a comes before b
      } else if (indexB != -1) {
        return 1; // b comes before a
      } else {
        return 0; // a and b are not in order list, leave them unchanged
      }
    });
    bookd = bookd.reversed.toList();
    if (returnvalue[0].contains('1')) {
      readbookerror = false;
    } else if (returnvalue[0].contains('2')) {
      readbookerror = true;
      errormsg = 'Empty List';
    } else if (returnvalue[0].contains('3')) {
      readbookerror = true;
      errormsg = 'Server Error';
    } else if (returnvalue[0].contains('4')) {
      readbookerror = true;
      errormsg = 'Request Timed Out';
    } else if (returnvalue[0].contains('5')) {
      readbookerror = true;
      errormsg = 'Unexpected Error';
    } else if (returnvalue[0].contains('6')) {
      readbookerror = true;
      errormsg = 'Something Went Wrong';
    }
    notifyListeners();
  }

  void getbookcpi() {
    final id = clickedbooks[0];
    print(id);
    int index = progress.indexWhere((item) {
      return item.startsWith(id.toString());
    });
    currentcpi = progress[index].split('-')[1];
    notifyListeners();
  }

  void deletebook(id) async {
    final pref = await SharedPreferences.getInstance();

    progress.removeWhere((element) => element.contains(id.toString()));

    pref.setStringList('progress', progress);
    getsavedbooks();
    GetReadBook();
    //notifyListeners();
  }
}
