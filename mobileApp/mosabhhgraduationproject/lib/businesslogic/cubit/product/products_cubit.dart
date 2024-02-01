
import 'package:bloc/bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/product_repo.dart';
import 'package:collection/collection.dart';

class ProductsCubit extends Cubit<GeneralState<List<Product>>> {
  final ProductRepo productRepo;
  List<Product>? allProducts;
  List<Product>? favProducts;

  ProductsCubit(this.productRepo) : super(InitialState());

  void getAllProducts() {
    emit(LoadingState());
    productRepo.getAllProducts().then((products) {
      emit(LoadedState(products));
     allProducts = products;
    }, onError: (error) {
      print("____weeee$error");
      emit(ErrorState("sth went wrong"));
    });
  }

  void filterProduct(ProductType type){
    var t=allProducts
        ?.where((product) => product.type == type)
        .toList();
    emit(LoadedState(t??[]));
  }

  void updateFav(int id,bool isFav){
    productRepo.updateFav(id, isFav).then((value){
     allProducts?.firstWhereOrNull((item) => item.id == id)?.isFavorite=isFav;
      emit(LoadedState(allProducts!));

    },onError:(error) {
    emit(ErrorState("sth went wrong"));

    });

  }

  void updateRating(int id,int rating){
    productRepo.updateRating(id, rating).then((value){
      allProducts?.firstWhereOrNull((item) => item.id == id)?.rating=rating.toDouble();
      emit(LoadedState(allProducts!));

    },onError:(error) {
      emit(ErrorState("sth went wrong"));
    });

  }


  void getFavProducts() {
    emit(LoadingState());
    productRepo.getAllProducts().then((products) {
      favProducts=products.where((element) => element.isFavorite).toList();
      emit(LoadedState(favProducts!));
    }, onError: (error) {
      emit(ErrorState("sth went wrong"));
    });
  }

  void removeFromFav(int id){
    productRepo.updateFav(id, false).then((value){
      favProducts?.removeWhere((element) => element.id==id);
      emit(LoadedState(favProducts!));

    },onError:(error) {
      emit(ErrorState("sth went wrong"));

    });
  }

}
