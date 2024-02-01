import 'dart:math';

import 'package:mosabhhgraduationproject/database/app_database.dart';
import 'package:postgres/postgres.dart';

class CartDataProvider{

  Future<List<dynamic>> getCartProduct(int userId) async {
    List<Map<String, dynamic>> products = [];
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      final response = await conn?.execute(Sql.named('SELECT * FROM public.cart WHERE "userId"=@userId AND "isPaid"=@isPaid '),parameters: {
        'userId':userId,
        'isPaid':false
      });
      response?.forEach((element) {
        products.add(element.toColumnMap());
      });
    } catch (exc) {
      print("Error: $exc");
    }
    return products;
  }

  Future<dynamic> getCartProductById(int id) async {
    List<Map<String, dynamic>> products = [];
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      final response = await conn?.execute(Sql.named('SELECT * FROM "products" WHERE product_id=@id '),parameters: {'id':id});
      response?.forEach((element) {
        products.add(element.toColumnMap());
      });
    } catch (exc) {
      print("Error: $exc");
    }
    return products[0];
  }



  Future<void> addToCart(int userId,int productId,bool isPaid,int productCount) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('INSERT INTO public.cart( "userId", "productId", "isPaid", "productCount")VALUES (@userId, @productId, @isPaid, @productCount);'), parameters: {
        'userId': userId,
        'productId':productId,
        'isPaid':isPaid,
        'productCount':productCount,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

  Future<void> updateCart(int userId,int productId,int cartId,int productCount) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('UPDATE public.cart SET  "productCount"=@productCount WHERE userId=@userId AND productId=@productId AND cartId=@cartId ;'), parameters: {
        'userId': userId,
        'productId':productId,
        'cartId': cartId,
        'productCount':productCount,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

  Future<void> removeProductFromCart(int userId,int productId,bool isPaid) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('DELETE FROM public.cart WHERE "userId"=@userId AND "productId"=@productId AND "isPaid"=@isPaid;'), parameters: {
        'userId': userId,
        'productId':productId,
        'isPaid':isPaid,
      });
    } catch (exc) {
      print("Error: $exc");
    }
  }

  Future<void> markCartAsPaid(int userId) async {
    try {
      final conn = await AppDatabase.instance().getConnectionInstance();
      await conn?.execute(
          Sql.named('UPDATE public.cart SET  "cartId"=@cartId, "isPaid"=@isPaid WHERE  "userId"=@userId AND "isPaid"=false ;'), parameters: {
        'userId': userId,
        'cartId': Random().nextInt(1000000000),
        'isPaid':true,
      });
      print("_______here");
    } catch (exc) {
      print("Error: $exc");
    }
  }
}