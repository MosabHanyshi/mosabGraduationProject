import 'package:mosabhhgraduationproject/data/dataproviders/card_data_provider.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/category_data_provider.dart';
import 'package:mosabhhgraduationproject/data/model/card.dart';
import 'package:mosabhhgraduationproject/data/model/product_category.dart';

class CategoriesRepo{
  final CategoryDataProvider categoryDataProvider;

  CategoriesRepo(this.categoryDataProvider);

  Future<List<ProductCategory>> getCategories() async {
    final categories = await categoryDataProvider.getCategories();
    return categories.map((cat) => ProductCategory.fromJson(cat as Map<String, dynamic>)).toList();
  }

}