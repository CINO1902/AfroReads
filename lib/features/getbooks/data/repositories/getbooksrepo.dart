import 'dart:io';

abstract class GetbookDatasource {
  Future<File> getbook();
}
