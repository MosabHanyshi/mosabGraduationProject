import 'package:bloc/bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/catagory/category_state.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/config/app_data.dart';
import 'package:mosabhhgraduationproject/data/model/product_category.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/category_repo.dart';

class CategoryCubit extends Cubit<GeneralState<List<ProductCategory>>> {
  CategoriesRepo categoriesRepo;
  CategoryCubit(this.categoriesRepo) : super(InitialState());

  void getAllCategories() {
    categoriesRepo.getCategories().then( (cat) {
      emit(LoadedState(cat));
    },onError: (error){
      print("_______error$error");

    });
  }
}
