
import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';

class ShopProduct extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const ShopProduct(
    this.product, {super.key, 
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: <Widget>[
            // ShopProductDisplay(
            //   product,
            //   onPressed: onRemove,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                product.name,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ],
        ));
  }
}

class ShopProductDisplay extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const ShopProductDisplay(this.product, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    List<String> substrings =product.images[0].split('.');

    return SizedBox(
      height: 150,
      width: 200,
      child: Stack(children: <Widget>[
        Positioned(
          left: 25,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset('assets/images/bottom_blue.png'),
            ),
          ),
        ),
        Positioned(
          left: 50,
          top: 5,
          child: SizedBox(
              height: 80,
              width: 80,
              child: Image.asset(
                'assets/${substrings[0]}.png',
                fit: BoxFit.contain,
              )),
        ),
        Positioned(
          right: 30,
          bottom: 25,
          child: Align(
            child: IconButton(
              icon: Image.asset('assets/images/red_clear.png'),
              onPressed: onPressed,
            ),
          ),
        )
      ]),
    );
  }
}
