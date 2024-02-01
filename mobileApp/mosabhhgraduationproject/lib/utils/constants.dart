import 'dart:math';

import 'package:mosabhhgraduationproject/data/model/categorical.dart';
import 'package:mosabhhgraduationproject/data/model/numerical.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/product_size_type.dart';

class AppConstant {
  const AppConstant._();

  static String dummyText =
      'Lorem Ipsum is simply dummy text of the printing and typesetting'
      ' industry. Lorem Ipsum has been the industry\'s standard dummy text'
      ' ever since the 1500s, when an unknown printer took a galley of type'
      ' and scrambled it to make a type specimen book.';


  static List<Product> products = [
    Product(
      name: 'Samsung Galaxy A53 5G',
      price: 460,
      about: dummyText,
      isAvailable: true,
      off: 300,
      quantity: 0,
      images: [
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
      ],
      isFavorite: true,
      rating: 1,
      type: ProductType.input,
    ),
    Product(
      name: 'Samsung Galaxy Tab S7 FE',
      price: 380,
      about: dummyText,
      isAvailable: false,
      off: 220,
      quantity: 0,
      images: [
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
      ],
      isFavorite: false,
      rating: 4,
      type: ProductType.input,
    ),
    Product(
      name: 'Samsung Galaxy Tab S8+',
      price: 650,
      about: dummyText,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
      ],
      isFavorite: false,
      rating: 3,
      type: ProductType.input,
    ),
    Product(
      name: 'Samsung Galaxy Watch 4',
      price: 229,
      about: dummyText,
      isAvailable: true,
      off: 200,
      quantity: 0,
      images: [
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
      ],
      isFavorite: false,
      rating: 5,
      sizes: ProductSizeType(
        categorical: [
          Categorical(CategoricalType.small, true),
          Categorical(CategoricalType.medium, false),
          Categorical(CategoricalType.large, false),
        ],
      ),
      type: ProductType.input,
    ),
    Product(
      name: 'Apple Watch 7',
      price: 330,
      about: dummyText,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
      ],
      isFavorite: false,
      rating: 4,
      sizes: ProductSizeType(
        numerical: [Numerical('41', true), Numerical('45', false)],
      ),
      type: ProductType.input,
    ),
    Product(
        name: 'Beats studio 3',
        price: 230,
        about: dummyText,
        isAvailable: true,
        off: null,
        quantity: 0,
        images: [
          'assets/images/headphones_3.png',
          'assets/images/headphones_3.png',
          'assets/images/headphones_3.png',
          'assets/images/headphones_3.png',
        ],
        isFavorite: false,
        rating: 2,
      type: ProductType.input,
    ),
    Product(
      name: 'Samsung Q60 A',
      price: 497,
      about: dummyText,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
      ],
      isFavorite: false,
      rating: 3,
      sizes: ProductSizeType(
        numerical: [
          Numerical('43', true),
          Numerical('50', false),
          Numerical('55', false)
        ],
      ),
      type: ProductType.input,
    ),
    Product(
      name: 'Sony x 80 J',
      price: 498,
      about: dummyText,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/headphones_3.png',
        'assets/images/headphones_3.png',
      ],
      isFavorite: false,
      sizes: ProductSizeType(
        numerical: [
          Numerical('50', true),
          Numerical('65', false),
          Numerical('85', false)
        ],
      ),
      rating: 2,
      type: ProductType.input,
    ),
  ];


  static List<List<Product>> headerProduct=[
    [
      Product(
        name: 'Potentiometer_1k',
        price: 3,
        about: dummyText,
        isAvailable: true,
        off: null,
        quantity: 0,
        images: [
          'images/pot.jpg',
        ],
        isFavorite: false,
        rating: 3,
        type: ProductType.input,
      ),
      Product(
        name: 'NTC Thermistor Tempreture',
        price: 12,
        about: dummyText,
        isAvailable: true,
        off: 300,
        quantity: 0,
        images: [
          'images/ntc.jpg',
        ],
        isFavorite: true,
        rating: 1,
        type: ProductType.input,
      ),
      Product(
        name: 'Samsung headset L325',
        price: 380,
        about: dummyText,
        isAvailable: false,
        off: 220,
        quantity: 0,
        images: [
          'assets/images/headphones_2.png',
        ],
        isFavorite: false,
        rating: 4,
        type: ProductType.input,
      ),

    ],
    [
      Product(
        name: 'Samsung headset L325',
        price: 380,
        about: dummyText,
        isAvailable: false,
        off: 220,
        quantity: 0,
        images: [
          'assets/images/headphones_2.png',
        ],
        isFavorite: false,
        rating: 4,
        type: ProductType.input,
      ),
      Product(
        name: 'Apple Watch',
        price: 460,
        about: dummyText,
        isAvailable: true,
        off: 300,
        quantity: 0,
        images: [
          'assets/images/apple_watch.png',
        ],
        isFavorite: true,
        rating: 1,
        type: ProductType.input,
      ),

      Product(
        name: 'Samsung headset X25',
        price: 650,
        about: dummyText,
        isAvailable: true,
        off: null,
        quantity: 0,
        images: [
          'assets/images/head_phone.png',
        ],
        isFavorite: false,
        rating: 3,
        type: ProductType.input,
      ),
    ],
    [
      Product(
        name: 'Apple Watch',
        price: 460,
        about: dummyText,
        isAvailable: true,
        off: 300,
        quantity: 0,
        images: [
          'assets/images/apple_watch.png',
        ],
        isFavorite: true,
        rating: 1,
        type: ProductType.input,
      ),
      Product(
        name: 'Samsung headset L325',
        price: 380,
        about: dummyText,
        isAvailable: false,
        off: 220,
        quantity: 0,
        images: [
          'assets/images/headphones_2.png',
        ],
        isFavorite: false,
        rating: 4,
        type: ProductType.input,
      ),
      Product(
        name: 'Samsung headset X25',
        price: 650,
        about: dummyText,
        isAvailable: true,
        off: null,
        quantity: 0,
        images: [
          'assets/images/head_phone.png',
        ],
        isFavorite: false,
        rating: 3,
        type: ProductType.input,
      ),
    ]
  ];

  List<List<Product>> getlists(List<Product> original){
    List<List<Product>> we =[];
    for (int i = 0; i < 3; i++) {
      we .add(getRandomItems(original,3));
    }
    return we;
  }

  static List<T> getRandomItems<T>(List<T> originalList, int count) {
    // Make a copy of the original list to avoid modifying it
    List<T> copyList = List.from(originalList);

    // Shuffle the copy list using the Dart random number generator
    copyList.shuffle(Random());

    // Take the specified number of items from the shuffled list
    return copyList.take(count).toList();
  }

  static List<String> timelines = ['The Best for you', 'now on Sales', 'Best of Month'];

}