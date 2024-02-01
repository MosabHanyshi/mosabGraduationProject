import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/product_repo.dart';
import 'package:collection/collection.dart';


class FavProductCubit extends Cubit<GeneralState<List<Product>>> {
  final ProductRepo productRepo;
  List<Product>? allProducts;

  FavProductCubit(this.productRepo) : super(InitialState());

  void getFavProducts() {
    emit(LoadingState());
    productRepo.getAllProducts().then((products) {
      emit(LoadedState(products.where((element) => element.isFavorite).toList()));
      allProducts=products;
    }, onError: (error) {
      emit(ErrorState("sth went wrong"));
    });
  }
  
  void removeFromFav(int id){
    productRepo.updateFav(id, false).then((value){
      allProducts?.removeWhere((element) => element.id==id);
      emit(LoadedState(allProducts!));

    },onError:(error) {
      emit(ErrorState("sth went wrong"));

    });
  }
}
