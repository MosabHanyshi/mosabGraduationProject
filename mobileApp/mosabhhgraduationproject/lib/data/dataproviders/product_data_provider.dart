import 'package:mosabhhgraduationproject/database/app_database.dart';
import 'package:postgres/postgres.dart';

class ProductDataProvider {
  Future<List<dynamic>> getAllProducts() async {
    List<Map<String, dynamic>> products = [];
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      final response = await conn?.execute(Sql.named('SELECT * FROM "products"'));
      response?.forEach((element) {
        products.add(element.toColumnMap());
      });
    } catch (exc) {
      print("Error: $exc");
    }
    return products;
  }

  Future<void> updateFav(int id, bool isFav) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('UPDATE "products" SET "isFav"= @isFav WHERE product_id=@id'), parameters: {
        'isFav': isFav,
        'id': id,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }
  Future<void> updateRate(int id, int rating) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('UPDATE "products" SET "rating"= @rating WHERE product_id=@id'), parameters: {
        'rating': rating,
        'id': id,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }
}
