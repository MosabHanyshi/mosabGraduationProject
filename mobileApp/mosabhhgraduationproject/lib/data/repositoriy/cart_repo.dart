import 'package:mosabhhgraduationproject/data/dataproviders/cart_data_provider.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';

class CartRepo {
  final CartDataProvider cartDataProvider;

  CartRepo(this.cartDataProvider);

  Future<List<Product>> getAllCartProducts(int userId) async {
    final cart = await cartDataProvider.getCartProduct(userId);
    Map<int, Product> productMap = {};
    print("_____json${cart}");

    // Iterate through the list and update the count for each product

    await Future.forEach(cart,(productData) async {
      print("_____cart${productData}");

      int productId = productData['productId'];

      // Check if the product is already in the map, if not, create a new instance
      if (!productMap.containsKey(productId)) {
          var product=await cartDataProvider.getCartProductById(productId);
        print("_____product${product}");

        productMap[productId] =  Product.fromJson(product as Map<String, dynamic>);
        print("_____map${productMap}");

      }

      // Increment the quantity for the existing product in the map
      productMap[productId]?.quantity += 1;
      print("_____product${productMap[productId]}");
    });
    return productMap.values.toList();
  }


  Future<void> addToCart(int userId, int productId) async {
    await cartDataProvider.addToCart(userId, productId, false, 1);
  }

  Future<void> updateCart(int userId, int productId, int cartId, int productCount) async {
    await cartDataProvider.updateCart(userId, productId, cartId, productCount);
  }

  Future<void> removeProductFromCart(int userId,int productId,bool isPaid) async {
    await cartDataProvider.removeProductFromCart(userId, productId, isPaid);
  }

  Future<void> markCartAsPaid(int userId) async {
    await cartDataProvider.markCartAsPaid(userId);
  }
  }