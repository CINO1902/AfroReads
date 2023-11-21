import 'package:afroreads/features/addbooks/domain/entities/Uploadmodel.dart';

abstract class UploadBookDatasource {
  Future<List<String>> uploadbook(Uploadbook uploadbook);
}
