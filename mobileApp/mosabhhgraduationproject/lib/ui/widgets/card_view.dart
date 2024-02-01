import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView(
      {super.key,
      required this.cardNumber,
      required this.ccv,
      required this.isDefult,
      required this.onCardPressed,
      required this.color});

  final String cardNumber;
  final String ccv;
  final Color color;
  final bool isDefult;
  final Function() onCardPressed;

  @override
  Widget build(BuildContext context) {
    String getCardIcon() {
      switch (cardNumber.substring(0, 1)) {
        case '4':
          {
            return 'assets/images/visa.png';
          }
        case '5':
        case '2':
          {
            return 'assets/images/mastercard.png';
          }
        default:
          {
            return 'assets/images/unknown.png';
          }
      }
    }

    return InkWell(
      onTap: () {onCardPressed();},
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: isDefult ? Border.all(color: Colors.red, width: 3.0) : null,
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                color,
                color.withAlpha(800),
                color.withAlpha(900),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Credit Card",
                    style: TextStyle(color: Colors.white),
                  ),
                  Center(child: Image.asset(getCardIcon())),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "**** **** **** ",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "theflutterlover",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              )
            ]),
      ),
    );
  }
}
