import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/catagory/category_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/catagory/category_state.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/products_cubit.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/product_category.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';
import 'package:mosabhhgraduationproject/ui/widgets/custom_background.dart';
import 'package:mosabhhgraduationproject/ui/widgets/list_item_selector.dart';
import 'package:mosabhhgraduationproject/ui/widgets/product_grid_view.dart';
import 'package:mosabhhgraduationproject/ui/widgets/product_list.dart';
import 'package:mosabhhgraduationproject/ui/widgets/progressBar.dart';
import 'package:mosabhhgraduationproject/ui/widgets/top_header.dart';
import 'package:mosabhhgraduationproject/utils/constants.dart';

enum AppbarActionType { leading, trailing }

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

int selectedTimeline = 0;
List<Product> product = AppConstant.headerProduct[0];
User? user;

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    getCurrentUser();
    BlocProvider.of<ProductsCubit>(context).getAllProducts();
    BlocProvider.of<CategoryCubit>(context).getAllCategories();
    super.initState();
  }
  List<List<Product>> test=[];

  void getCurrentUser() {
    SharedP().getCachedUser().then((value) {
      setState(() {
        user = value;
      });
    }, onError: (error) {});
  }

  Widget _topCategoriesHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.categoryList);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
            child: Text(
              "SEE ALL",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.deepOrange.withOpacity(0.7)),
            ),
          )
        ],
      ),
    );
  }

  Widget _topCategoriesListView() {
    return BlocBuilder<CategoryCubit, GeneralState<List<ProductCategory>>>(
        builder: (context, state) {
      if (state is LoadedState) {
        return ListItemSelector(
          categories: (state as LoadedState).data,
          onItemPressed: (type) {
            BlocProvider.of<ProductsCubit>(context).filterProduct(type);
          },
        );
      } else {
        return Container();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomPaint(
        painter: MainBackground(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Hello',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow95)),
                        TextSpan(
                            text: user?.firstName==null?" Mosab":' ${user?.firstName??""}!',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Lets gets somethings?",
                        style: TextStyle(color: Colors.black12),
                      )),
                  BlocConsumer<ProductsCubit, GeneralState<List<Product>>>(
                    listener: (context, state) {
                      if (state is LoadedState) {
                        test = [
                          AppConstant.getRandomItems(
                              (state as LoadedState).data, 3),
                          AppConstant.getRandomItems(
                              (state as LoadedState).data, 3),
                          AppConstant.getRandomItems(
                              (state as LoadedState).data, 3)
                        ];
                      }
                    },
                    builder: (context, state) {
                      return BlocBuilder<ProductsCubit,
                          GeneralState<List<Product>>>(
                        builder: (context, state) {
                          if (state is LoadedState) {
                            return TopHeader(
                              onPressed: (int index) async {
                                setState(() {
                                  selectedTimeline = index;
                                  product = test[index];
                                });
                              },
                              selectedTimeline: selectedTimeline,
                            );
                          } else {
                            return const ProgressBar();
                          }
                        },
                      );
                    },
                  ),
                  ProductList(
                    products: product,
                  ),
                  _topCategoriesHeader(context),
                  _topCategoriesListView(),
                  BlocBuilder<ProductsCubit, GeneralState<List<Product>>>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        // Show loading indicator
                        return const ProgressBar();
                      } else if (state is LoadedState) {
                        return ProductGridView(
                          productsCubit:
                              BlocProvider.of<ProductsCubit>(context),
                          items: (state as LoadedState).data,
                          likeButtonPressed: (id, isFav) => {
                            BlocProvider.of<ProductsCubit>(context)
                                .updateFav(id, isFav)
                          },
                          isPriceOff: (product) => isPriceOff(product),
                        );
                      } else if (state is EmptyState) {
                        // Handle case when there are no products
                        return const Text('No products available.');
                      } else if (state is ErrorState) {
                        // Handle error state
                        return Text('Error: ${(state as ErrorState).error}');
                      } else {
                        return Text('Unhandled state: $state');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool isPriceOff(Product product) => product.off != null;
