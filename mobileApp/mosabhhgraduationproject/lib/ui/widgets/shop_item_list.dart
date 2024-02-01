import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/ui/widgets/color_option.dart';
import 'package:mosabhhgraduationproject/ui/widgets/shop_product.dart';
import 'package:numberpicker/numberpicker.dart';

class ShopItemList extends StatefulWidget {
  final Product product;
  final VoidCallback onRemove;
  final Function(int) onCountChanged;


  const ShopItemList(this.product, {super.key, required this.onRemove,required this.onCountChanged});

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  int quantity = 1;

  @override
  void initState() {
    setQuantity();
    super.initState();
  }

  void setQuantity() {
    setState(() {
      quantity = widget.product.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 130,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(0, 0.8),
            child: Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: AppColors.shadow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.only(left: 50),
                                child: Flexible(
                                  child: Text(
                                    widget.product.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(widget.product.price!=null?
                                  '\$${(widget.product.price-((widget.product.off )!/100)*widget.product.price).toStringAsFixed(2) }':'\$${(widget.product.price)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Theme(
                          data: ThemeData(
                              hintColor: Colors.black,
                              textTheme: TextTheme(
                                titleLarge: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                bodyLarge: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              )),
                          child: NumberPicker(
                            selectedTextStyle: const TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            value: quantity,
                            minValue: 1,
                            maxValue: 10,
                            itemWidth: 50,
                            zeroPad: true,
                            onChanged: (value) {
                              setState(() {
                                quantity = value;
                                widget.onCountChanged(value);
                              });
                            },
                          ))
                    ])),
          ),
          Positioned(
              top: 5,
              child: ShopProductDisplay(
                widget.product,
                onPressed: widget.onRemove,
              )),
        ],
      ),
    );
  }
}
