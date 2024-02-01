import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/address/address_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cards/cards_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cart/cart_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/Address.dart';
import 'package:mosabhhgraduationproject/data/model/card.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';
import 'package:mosabhhgraduationproject/ui/screens/mapScreen.dart';
import 'package:mosabhhgraduationproject/ui/widgets/address_selector.dart';
import 'package:mosabhhgraduationproject/ui/widgets/card_view.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved_top.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int activeCard = 0;
  User? currentUser;
  String mpalce = "";

  @override
  void initState() {
    BlocProvider.of<CardsCubit>(context).getAllCards();
    BlocProvider.of<AddressCubit>(context).getAllAddress();

    getUser();
    super.initState();
  }

  void getUser() {
    SharedP().getCachedUser().then((user) {
      currentUser = user;
      BlocProvider.of<CartCubit>(context).getAllProducts(user?.id ?? 1);
    }, onError: (error) {});
  }

  @override
  Widget build(BuildContext context) {
    final _paerController = PageController();
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          const Positioned(top: 0, left: 0, child: CurvedTop()),
          Positioned(
              top: 15,
              left: 0,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const Text(
                    'Payment',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: BlocBuilder<CartCubit, GeneralState<List<Product>>>(
                    builder: (context, state) {
                      var total = 0;
                      var discount = 0;
                      var wholeTotal = 0;
                      if (state is LoadedState) {
                        ((state as LoadedState).data as List<Product>)
                            .forEach((element) {
                          total += element.quantity * element.price;
                          discount += element.off == null
                              ? 0
                              : (((element.off)! / 100) * element.price)
                                  .toInt();
                          wholeTotal += element.off == null
                              ? (element.quantity * element.price)
                              : (element.quantity *
                                      (element.price -
                                          (((element.off)! / 100) *
                                              element.price)))
                                  .toInt();
                        });
                        wholeTotal += 20;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Price Details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'price',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$ ${total.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    ' ${discount.toStringAsFixed(2)} %',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery charge ',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$ 20',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$ ${wholeTotal.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Price Details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'price',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$ $total',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$ $discount',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery charge ',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$ 20',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '\$ $wholeTotal',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              'Select Address',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<AddressCubit, GeneralState<List<Address>>>(
                        builder: (context, state) {
                          if (state is LoadedState) {
                            List<Address> test = (state as LoadedState).data;
                            return AddressSelector(
                              address: test,
                              onItemPressed: (index) {
                                setState(() {
                                  mpalce = test[index].placeName ?? "";
                                });
                              },
                              onAddPressed: () async {
                                dynamic result = await Navigator.pushNamed(
                                    context, AppRoutes.addNewAddress);
                                if (result != null) {
                                  setState(() {
                                    BlocProvider.of<CartCubit>(context)
                                        .getAllProducts(currentUser?.id ?? 1);
                                  });
                                }
                              },
                            );
                          } else {
                            return AddressSelector(
                              address: [],
                              onItemPressed: (index) {},
                              onAddPressed: () async {
                                dynamic result = await Navigator.pushNamed(
                                    context, AppRoutes.addNewAddress);
                                if (result != null) {
                                  BlocProvider.of<CartCubit>(context)
                                      .getAllProducts(currentUser?.id ?? 1);
                                }
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(new Radius.circular(10.0)),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10),
                              child:
                                  Text(mpalce.isEmpty ? "City/Street" : mpalce,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.start),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.transparentBlue3,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                highlightColor: Colors.orange,
                                color: Colors.orange,
                                icon: FaIcon(
                                  Icons.gps_fixed,
                                  color: AppColors.primaryBlue,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => MapScreen()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                'Select Card',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<CardsCubit, GeneralState<List<CreditCard>>>(
                          builder: (context, state) {
                            CreditCard? card;
                            if (state is LoadedState) {
                              card = ((state as LoadedState).data
                                      as List<CreditCard>?)
                                  ?.firstWhere(
                                      (card) => card.isDefault == true);
                              if (card == null) {
                                card = ((state as LoadedState).data
                                    as List<CreditCard>)[0];
                              }

                              return SizedBox(
                                height: 160,
                                child: card == null
                                    ? Container()
                                    : Container(
                                        height: 160,
                                        child: CardView(
                                          isDefult: false,
                                          onCardPressed: () {},
                                          cardNumber:
                                              card.number?.toString() ?? "",
                                          ccv: card.cvv?.toString() ?? "",
                                          color: card.color?.color ??
                                              Colors.yellow,
                                        ),
                                      ),
                              );
                            } else {
                              return Container();
                            }
                            ;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: OutlinedButton(
                                onPressed: () async {
                                  final haveAddedACard =
                                      await Navigator.pushNamed(
                                          context, AppRoutes.cardList);
                                  if (haveAddedACard != null) {
                                    BlocProvider.of<CardsCubit>(context)
                                        .getAllCards();
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  shadowColor: Colors.grey,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero,
                                  side: const BorderSide(
                                      color: AppColors.primaryBlue),
                                  // Set this
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  foregroundColor: AppColors.primaryBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const Text(
                                  'SHOW MORE',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 20, top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        BlocProvider.of<CartCubit>(context)
                            .markCartAsPaid(currentUser?.id ?? 0);
                        Navigator.of(context).pop(true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('payment done successfully ')),
                        );
                      },
                      child: const Text("Buy Now"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
