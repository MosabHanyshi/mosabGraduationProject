import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cart/cart_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/fav_product_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/product/products_cubit.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/cart_data_provider.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/product_data_provider.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/cart_repo.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/product_repo.dart';
import 'package:mosabhhgraduationproject/ui/screens/product_detail_screen.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.productCubit,
    required this.child,
    required this.product,
  });

  final ProductsCubit productCubit;

  final Widget child;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      closedColor: (Colors.white.withOpacity(0.1)),
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 850),
      closedBuilder: (_, VoidCallback openContainer) {
        return InkWell(onTap: openContainer, child: child);
      },
      openBuilder: (_, __) =>
          BlocProvider.value(
            value: productCubit,
            child: BlocProvider(
              create: (context) => CartCubit(CartRepo(CartDataProvider())),
              child: ProductDetailScreen(product),
            ),
          ),
    );
  }
}
