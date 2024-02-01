import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<GeneralState<List<Product>>> {
  CartRepo cartRepo;
  List<Product>? allProducts;

  CartCubit(this.cartRepo) : super(InitialState());

  void getAllProducts(int userId) {
    emit(LoadingState());
    cartRepo.getAllCartProducts(userId).then((products) {
      if(products.isEmpty){
        emit(EmptyState());
      }
      else{
      emit(LoadedState(products));
      allProducts = products;}
    }, onError: (error) {
      emit(ErrorState("sth went wrong"));
    });
  }

  void addToCart(int userId, int productId) async {
    cartRepo.addToCart(userId, productId).then((value){
    },onError:(error) {
      emit(ErrorState("sth went wrong"));

    });

  }
  void updateCart(int userId, int productId, int cartId, int productCount) async {
    cartRepo.updateCart(userId, productId,cartId,productCount).then((value){
    },onError:(error) {
      emit(ErrorState("sth went wrong"));

    });

  }

  void removeCart(int userId, int productId) async {
    cartRepo.removeProductFromCart(userId, productId,false).then((value){
      allProducts?.removeWhere((element) => element.id==productId);
      if(allProducts?.isEmpty==true){
        emit(EmptyState());
      }else{
      emit(LoadedState(allProducts!));}

    },onError:(error) {
      emit(ErrorState("sth went wrong"));

    });

  }

  void markCartAsPaid(int userId) async {
cartRepo.markCartAsPaid(userId).then((value){
  allProducts=[];
  emit(EmptyState());

},onError:(error) {
  emit(ErrorState("sth went wrong"));

});
  }}
