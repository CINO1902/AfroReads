import 'dart:convert';
import 'dart:io';
import 'package:afroreads/features/addbooks/domain/entities/Uploadmodel.dart';
import 'package:afroreads/features/addbooks/domain/repositories/uploadbook_repo.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class uploadimageprovider extends ChangeNotifier {
  File? image;
  File? book;
  bool error = false;
  String msg = '';
  String bookage = '';
  bool uploadingimage = false;
  bool uploadingbook = false;
  bool errorbook = false;
  String imageurl = '';
  String bookurl = '';
  bool uploaderror = false;
  String es = '';
  bool loading = false;
  int _value = 0;
  int _group = 0;
  int _index = 0;
  final UploadBookRepo uploadBookRepo;
  uploadimageprovider(this.uploadBookRepo);
  int get value => _value;
  int get group => _group;
  int get index => _index;

  Future<void> pickimage() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result == null) {
        return;
      }
      final ImageTemporary = File(result.path);

      image = ImageTemporary;
    } catch (e) {
      error = true;
      es = e.toString();
    }
    notifyListeners();
  }

  Future<void> pickfile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub'],
      );
      if (result == null) {
        return;
      }
      final bookTemporary = File(result.paths[0]!);

      book = bookTemporary;
    } catch (e) {
      errorbook = true;
      print(e.toString());
      es = e.toString();
    }
    notifyListeners();
  }

  Future<void> uploadimage() async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dlsavisdq/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'image_preset'
      ..files.add(await http.MultipartFile.fromPath('file', image!.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);

      final url = jsonMap['url'];
      imageurl = url;
      print(imageurl);
      uploadingimage = false;
      notifyListeners();
    }
  }

  Future<void> sendrequest(
      booktitle, author, description, genre, addedby) async {
    loading = true;
    notifyListeners();
    uploadingimage = true;
    await uploadimage();

    await uploadbook();
    uploadingbook = false;
    notifyListeners();

    Uploadbook uploadbooks = Uploadbook(
        bookTitle: booktitle,
        authorName: author,
        preview: description,
        link: bookurl,
        bookage: bookage,
        addedBy: addedby,
        imageUrl: imageurl,
        genre: genre);

    final response = await uploadBookRepo.uploadbook(uploadbooks);
    if (response[0] == '1') {
      msg = 'Book Uploaded Successfully';
      uploaderror = false;
    } else if (response[0] == '2') {
      msg = 'Server Error';
      uploaderror = true;
    } else if (response[0] == '3') {
      msg = 'Request Timed Out';
      uploaderror = true;
    } else if (response[0] == '4') {
      msg = 'Unexpected Error';
      uploaderror = true;
    } else if (response[0] == '5') {
      msg = 'Something went wrong';
      uploaderror = true;
    }

    loading = false;
  }

  Future<void> uploadbook() async {
    uploadingbook = true;
    notifyListeners();
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dlsavisdq/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'book_preset'
      ..files.add(await http.MultipartFile.fromPath('file', book!.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);

      final url = jsonMap['url'];
      bookurl = url;

      notifyListeners();
    }
  }

  void collectbookage(book) {
    if (book == 1) {
      bookage = "0-8";
    } else if (book == 2) {
      bookage = "9-13";
    } else if (book == 3) {
      bookage = '14-16';
    }
    notifyListeners();
  }

  void deleteimage() {
    image = null;

    notifyListeners();
  }

  showindex(_value) {
    _group = _value;
    _index = _value;

    notifyListeners();
  }

  void deletebook() {
    book = null;

    notifyListeners();
  }
}
