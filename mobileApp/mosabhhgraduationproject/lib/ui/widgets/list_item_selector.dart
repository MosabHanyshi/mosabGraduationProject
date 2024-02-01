import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/product.dart';
import 'package:mosabhhgraduationproject/data/model/product_category.dart';

class ListItemSelector extends StatefulWidget {
  const ListItemSelector({
    super.key,
    required this.categories,
    required this.onItemPressed,
  });

  final List<ProductCategory> categories;
  final Function(ProductType) onItemPressed;

  @override
  State<ListItemSelector> createState() => _ListItemSelectorState();
}

class _ListItemSelectorState extends State<ListItemSelector> {
  Widget item(ProductCategory item, int index) {
    return Tooltip(
      message: item.type!.name!.capitalizeFirst,
      child: AnimatedContainer(
        margin: const EdgeInsets.only(left: 7, right: 7, bottom: 7),
        duration: const Duration(milliseconds: 500),
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 10.0,
              color: Colors.blue.withOpacity(0.3),
            )
          ],
          color:
              item.isSelected == false ? AppColors.whiteFe : AppColors.yellow95,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          splashRadius: 0.1,
          icon: FaIcon(
            item.type==ProductType.input?Icons.settings_input_hdmi_rounded:item.type==ProductType.output?Icons.airplay_outlined:Icons.crop_square_sharp,
            color: item.isSelected == false ? Colors.black : Colors.white,
          ),
          onPressed: () {
            widget.onItemPressed(widget.categories[index]!.type!);
            for (var element in widget.categories) {
              element.isSelected = false;
            }

            item.isSelected = true;
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (_, index) => item(widget.categories[index], index),
      ),
    );
  }
}
