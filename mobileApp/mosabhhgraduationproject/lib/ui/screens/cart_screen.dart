import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cart/cart_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';
import 'package:mosabhhgraduationproject/ui/animation/animated_switcher_wrapper.dart';
import 'package:mosabhhgraduationproject/ui/widgets/empty_cart.dart';
import 'package:mosabhhgraduationproject/ui/widgets/progressBar.dart';
import 'package:mosabhhgraduationproject/ui/widgets/shop_item_list.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? currentUser;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {
    SharedP().getCachedUser().then((user) {
      currentUser = user;
      BlocProvider.of<CartCubit>(context).getAllProducts(user?.id ?? 0);
    });
  }

  var count = 0;

  Widget bottomBarTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          AnimatedSwitcherWrapper(
            child: BlocBuilder<CartCubit, GeneralState<List<Product>>>(
              builder: (context, state) {
                if (state is LoadedState) {
                  count = 0;
                  ((state as LoadedState).data as List<Product>)
                      .forEach((element) {
                    count += element.off != null
                        ? ((element.price -
                                    (((element.off)! / 100) * element.price)) *
                                element.quantity)
                            .toInt()
                        : (element.quantity * element.price);
                  });
                  return Text(
                    "\$${count.toStringAsFixed(3)}",
                    key: ValueKey<int>(0),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFEC6813),
                    ),
                  );
                } else {
                  return Text(
                    "\$${0}",
                    key: ValueKey<int>(0),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFEC6813),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget bottomBarButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: BlocBuilder<CartCubit, GeneralState<List<Product>>>(
          builder: (context, state) {
            var haveElement = false;
            if (state is LoadedState) {
              haveElement =
                  ((state as LoadedState).data as List<Product>).isNotEmpty;
            }
            return ElevatedButton(
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
              onPressed: !haveElement
                  ? null
                  : () async {
                      final result = await Navigator.pushNamed(
                          context, AppRoutes.checkout);
                      if (result != null) {
                        BlocProvider.of<CartCubit>(context)
                            .getAllProducts(currentUser?.id ?? 0);
                      }
                    },
              child: const Text("Checkout"),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/curve.png'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: true
                  ? SizedBox(
                      height: 300,
                      child:
                          BlocBuilder<CartCubit, GeneralState<List<Product>>>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            // Show loading indicator
                            return const ProgressBar();
                          } else if (state is LoadedState) {
                            List<Product> products =
                                (state as LoadedState).data;
                            return Scrollbar(
                              child: ListView.builder(
                                itemBuilder: (_, index) => ShopItemList(
                                  products[index],
                                  onRemove: () {
                                    BlocProvider.of<CartCubit>(context)
                                        .removeCart(currentUser?.id ?? 0,
                                            products[index].id ?? 0);
                                    count -= (products[index].off == null
                                        ? ((products[index].price -
                                                    (((products[index].off)! /
                                                            100) *
                                                        products[index]
                                                            .price)) *
                                                products[index].quantity)
                                            .toInt()
                                        : (products[index].quantity *
                                                products[index].price)
                                            .toInt());
                                  },
                                  onCountChanged: (count) {
                                    setState(() {
                                      products[index].quantity = count;
                                    });
                                  },
                                ),
                                itemCount: products.length,
                              ),
                            );
                          } else if (state is EmptyState) {
                            // Handle case when there are no products
                            return const Text('No products available.');
                          } else if (state is ErrorState) {
                            // Handle error state
                            return Text(
                                'Error: ${(state as ErrorState).error}');
                          } else {
                            return Text('Unhandled state: $state');
                          }
                        },
                      ))
                  : const EmptyCart(),
            ),
            bottomBarTitle(),
            bottomBarButton()
          ],
        ),
      ),
    );
  }
}
