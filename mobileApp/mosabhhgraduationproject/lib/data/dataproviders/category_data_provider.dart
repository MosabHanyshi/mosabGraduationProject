import 'package:mosabhhgraduationproject/database/app_database.dart';
import 'package:postgres/postgres.dart';

class CategoryDataProvider {
  Future<List<Map<String, dynamic>>> getCategories() async {
    List<Map<String, dynamic>> categories = [];

    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      final response = await conn?.execute(Sql.named('SELECT * FROM public."categories"'));

      response?.forEach((element) {
        categories.add(element.toColumnMap());
      });
    } catch (exc) {
      print("Error: $exc");
    }

    return categories;
  }
}
