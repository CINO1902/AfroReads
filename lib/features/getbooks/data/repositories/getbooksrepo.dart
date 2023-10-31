

abstract class GetbookDatasource {
  Future<List<List>> getbook(page, limit);
  Future<List<List>> callbookdetails(id);
}
