import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cart/cart_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/products_cubit.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';

import 'package:mosabhhgraduationproject/ui/widgets/back_button.dart';
import 'package:mosabhhgraduationproject/ui/widgets/carousel_slider.dart';
import 'package:mosabhhgraduationproject/ui/widgets/page_wrapper.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  User? currentUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
  void getCurrentUser(){
    SharedP().getCachedUser().then((value) {
      setState(() {
        currentUser=value;

      });
    },onError: (error){

    });

  }
  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.42,
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: CarouselSlider(items: widget.product.images),
    );
  }

  Widget _ratingBar(BuildContext context) {
    return Wrap(
      spacing: 30,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: widget.product.rating,
          direction: Axis.horizontal,
          itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (value) {
            BlocProvider.of<ProductsCubit>(context)
                .updateRating(widget.product.id ?? 0, value.toInt());
          },
        ),
        Text(
          "",
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.w300),
        )
      ],
    );
  }

  Widget productSizesListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () => {},
          child: AnimatedContainer(
            margin: const EdgeInsets.only(right: 5, left: 5),
            alignment: Alignment.center,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 0.4),
            ),
            duration: const Duration(milliseconds: 300),
            child: const FittedBox(
              child: Text(
                "test",
                // controller.sizeType(product)[index].numerical,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const MyBackButton(),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productPageView(width, height),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      _ratingBar(context),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            widget.product.off != null
                                ? "\$${(widget.product.price-((widget.product.off!/100)*widget.product.price)).toStringAsFixed(2)}"
                                : "\$${widget.product.price.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(width: 3),
                          Visibility(
                            visible: widget.product.off != null ? true : false,
                            child: Text(
                              "\$${widget.product.price}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.product.isAvailable
                                ? "Available in stock"
                                : "Not available",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "About",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(widget.product.about),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return AppColors.transparentBlue02;
                                }
                                return AppColors
                                    .primaryBlue; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<CartCubit>(context)
                                .addToCart(currentUser?.id??0, widget.product.id??0);
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('product have been added to cart succesfully')),
                          );
                          Navigator.pop(context);
                          },
                          child: const Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
