import 'package:mosabhhgraduationproject/data/dataproviders/product_data_provider.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';

class ProductRepo {
  final ProductDataProvider productDataProvider;

  ProductRepo(this.productDataProvider);

  Future<List<Product>> getAllProducts() async {
    final products = await productDataProvider.getAllProducts();
    print("__________tt_${products}");

    return products.map((product) => Product.fromJson(product as Map<String, dynamic>)).toList();
  }

  Future<void> updateFav(int id, bool isFav) async {
   await productDataProvider.updateFav(id, isFav);
  }

  Future<void> updateRating(int id, int rating) async {
    await productDataProvider.updateRate(id, rating);
  }
}
