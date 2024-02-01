import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/fav_product_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/products_cubit.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/ui/widgets/product_grid_view.dart';
import 'package:mosabhhgraduationproject/ui/widgets/progressBar.dart';
import 'package:mosabhhgraduationproject/utils/constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).getFavProducts();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/curve.png'),
                    fit: BoxFit.cover)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: BlocBuilder<ProductsCubit, GeneralState<List<Product>>>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    // Show loading indicator
                    return const ProgressBar();
                  } else if (state is LoadedState) {
                    return ProductGridView(
                      productsCubit: BlocProvider.of<ProductsCubit>(context),
                      items: (state as LoadedState).data,
                      likeButtonPressed: (id,isFav) => {
                        BlocProvider.of<ProductsCubit>(context).removeFromFav(id)
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
              )),
        ],
      ),
    );
  }
}

bool isPriceOff(Product product) => product.off != null;
