import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/product_category.dart';

abstract class CategoryState{}

class CategoryInitial extends CategoryState{}

class LoadedCategoryState extends CategoryState {
  final List<ProductCategory> data;

  LoadedCategoryState(this.data);
}
class SelectCategoryState extends CategoryState {
  final ProductType type;

  SelectCategoryState(this.type);
}
