import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/bottom_navy_bar_item.dart';
import 'package:mosabhhgraduationproject/data/model/categorical.dart';
import 'package:mosabhhgraduationproject/data/model/numerical.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/product_category.dart';
import 'package:mosabhhgraduationproject/data/model/product_size_type.dart';
import 'package:mosabhhgraduationproject/data/model/recommended_product.dart';

import 'package:mosabhhgraduationproject/utils/constants.dart';

class AppData {
  const AppData._();


  // static List<Product> products = [
  //   Product(
  //     name: 'Samsung Galaxy A53 5G',
  //     price: 460,
  //     about: AppConstant.dummyText,
  //     isAvailable: true,
  //     off: 300,
  //     quantity: 0,
  //     images: [
  //       'assets/images/a53_1.png',
  //       'assets/images/a53_2.png',
  //       'assets/images/a53_3.png'
  //     ],
  //     isFavorite: true,
  //     rating: 1,
  //     type: ProductType.mobile,
  //   ),
  //   Product(
  //     name: 'Samsung Galaxy Tab S7 FE',
  //     price: 380,
  //     about: AppConstant.dummyText,
  //     isAvailable: false,
  //     off: 220,
  //     quantity: 0,
  //     images: [
  //       'assets/images/tab_s7_fe_1.png',
  //       'assets/images/tab_s7_fe_2.png',
  //       'assets/images/tab_s7_fe_3.png'
  //     ],
  //     isFavorite: false,
  //     rating: 4,
  //     type: ProductType.tablet,
  //   ),
  //   Product(
  //     name: 'Samsung Galaxy Tab S8+',
  //     price: 650,
  //     about: AppConstant.dummyText,
  //     isAvailable: true,
  //     off: null,
  //     quantity: 0,
  //     images: [
  //       'assets/images/tab_s8_1.png',
  //       'assets/images/tab_s8_2.png',
  //       'assets/images/tab_s8_3.png',
  //     ],
  //     isFavorite: false,
  //     rating: 3,
  //     type: ProductType.tablet,
  //   ),
  //   Product(
  //     name: 'Samsung Galaxy Watch 4',
  //     price: 229,
  //     about: AppConstant.dummyText,
  //     isAvailable: true,
  //     off: 200,
  //     quantity: 0,
  //     images: [
  //       'assets/images/galaxy_watch_4_1.png',
  //       'assets/images/galaxy_watch_4_2.png',
  //       'assets/images/galaxy_watch_4_3.png',
  //     ],
  //     isFavorite: false,
  //     rating: 5,
  //     sizes: ProductSizeType(
  //       categorical: [
  //         Categorical(CategoricalType.small, true),
  //         Categorical(CategoricalType.medium, false),
  //         Categorical(CategoricalType.large, false),
  //       ],
  //     ),
  //     type: ProductType.watch,
  //   ),
  //   Product(
  //     name: 'Apple Watch 7',
  //     price: 330,
  //     about: AppConstant.dummyText,
  //     isAvailable: true,
  //     off: null,
  //     quantity: 0,
  //     images: [
  //       'assets/images/apple_watch_series_7_1.png',
  //       'assets/images/apple_watch_series_7_2.png',
  //       'assets/images/apple_watch_series_7_3.png',
  //     ],
  //     isFavorite: false,
  //     rating: 4,
  //     sizes: ProductSizeType(
  //       numerical: [Numerical('41', true), Numerical('45', false)],
  //     ),
  //     type: ProductType.watch,
  //   ),
  //   Product(
  //       name: 'Beats studio 3',
  //       price: 230,
  //       about:AppConstant. dummyText,
  //       isAvailable: true,
  //       off: null,
  //       quantity: 0,
  //       images: [
  //         'assets/images/beats_studio_3-1.png',
  //         'assets/images/beats_studio_3-2.png',
  //         'assets/images/beats_studio_3-3.png',
  //         'assets/images/beats_studio_3-4.png',
  //       ],
  //       isFavorite: false,
  //       rating: 2,
  //       type: ProductType.headphone),
  //   Product(
  //     name: 'Samsung Q60 A',
  //     price: 497,
  //     about: AppConstant.dummyText,
  //     isAvailable: true,
  //     off: null,
  //     quantity: 0,
  //     images: [
  //       'assets/images/samsung_q_60_a_1.png',
  //       'assets/images/samsung_q_60_a_2.png',
  //     ],
  //     isFavorite: false,
  //     rating: 3,
  //     sizes: ProductSizeType(
  //       numerical: [
  //         Numerical('43', true),
  //         Numerical('50', false),
  //         Numerical('55', false)
  //       ],
  //     ),
  //     type: ProductType.tv,
  //   ),
  //   Product(
  //     name: 'Sony x 80 J',
  //     price: 498,
  //     about: AppConstant.dummyText,
  //     isAvailable: true,
  //     off: null,
  //     quantity: 0,
  //     images: [
  //       'assets/images/sony_x_80_j_1.png',
  //       'assets/images/sony_x_80_j_2.png',
  //     ],
  //     isFavorite: false,
  //     sizes: ProductSizeType(
  //       numerical: [
  //         Numerical('50', true),
  //         Numerical('65', false),
  //         Numerical('85', false)
  //       ],
  //     ),
  //     rating: 2,
  //     type: ProductType.tv,
  //   ),
  // ];

  // static List<ProductCategory> categories = [
  //
  //   ProductCategory(
  //     ProductType.mobile,
  //     true,
  //     FontAwesomeIcons.mobileScreenButton,
  //     'assets/imgs/headphones_3.png',
  //   ),
  //   ProductCategory(ProductType.watch, false, Icons.watch,        'assets/imgs/headphones_3.png',
  //   ),
  //   ProductCategory(
  //     ProductType.tablet,
  //     false,
  //     FontAwesomeIcons.tablet,
  //     'assets/imgs/headphones_3.png',
  //
  //   ),
  //   ProductCategory(
  //     ProductType.headphone,
  //     false,
  //     Icons.headphones,
  //     'assets/imgs/headphones_3.png',
  //
  //   ),
  //   ProductCategory(
  //     ProductType.tv,
  //     false,
  //     Icons.tv,
  //     'assets/imgs/headphones_3.png',
  //   ),
  // ];


  static List<BottomNavyBarItem> bottomNavyBarItems = [
    BottomNavyBarItem(
        "Home",
        const Icon(Icons.home),
      AppColors.primaryBlue,
        Colors.grey,
    ),
    BottomNavyBarItem(
      "Favorite",
      const Icon(Icons.favorite),
      AppColors.primaryBlue,
      Colors.grey,
    ),
    BottomNavyBarItem(
      "Cart",
      const Icon(Icons.shopping_cart),
      const Color(0xFFEC6813),
      Colors.grey,
    ),
    BottomNavyBarItem(
      "Profile",
      const Icon(Icons.person),
      AppColors.primaryBlue,
      Colors.grey,
    ),
  ];

  static List<RecommendedProduct> recommendedProducts = [
    RecommendedProduct(
      imagePath: "",
      cardBackgroundColor: const Color(0xFFEC6813),
    ),
    RecommendedProduct(
      imagePath: "",
      cardBackgroundColor: const Color(0xFF3081E1),
      buttonBackgroundColor: const Color(0xFF9C46FF),
      buttonTextColor: Colors.white,
    ),
  ];
}
