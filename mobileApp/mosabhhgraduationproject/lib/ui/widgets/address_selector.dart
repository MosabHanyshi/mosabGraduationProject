import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/Address.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({
    super.key,
    required this.address,
    required this.onItemPressed,
    required this.onAddPressed,

  });

  final List<Address> address;
  final Function(int) onItemPressed;
  final Function() onAddPressed;


  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  Widget item(Address item, int index) {
    return index!=widget.address.length?InkWell(
      onTap: () {
        widget.onItemPressed(index);
        for (var element in widget.address) {
          element.isSelected = false;
        }

        item.isSelected = true;
        setState(() {});
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(left: 7,right: 7,bottom: 7),
        duration: const Duration(milliseconds: 500),
        width: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 10.0,
              color: Colors.blue.withOpacity(0.3),
            )
          ],
          color: item.isSelected == false
              ? AppColors.whiteFe
              : AppColors.yellow95,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            IconButton(
              splashRadius: 0.1,
              icon: FaIcon(
                item.icon,
                color: item.isSelected == false ? AppColors.primaryBlue : Colors.white,
              ),
              onPressed: () {
                widget.onItemPressed(index);
                for (var element in widget.address) {
                  element.isSelected = false;
                }

                item.isSelected = true;
                setState(() {});
              },
            ),
            Text(
              item.name??"",
              style: TextStyle(
                fontSize: 8,
                overflow: TextOverflow.ellipsis,
                color: item.isSelected == false ? AppColors.primaryBlue : Colors.black,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ):InkWell(
      onTap: () {

      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(left: 7,right: 7,bottom: 7),
        duration: const Duration(milliseconds: 500),
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryBlue),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 10.0,
              color: Colors.blue.withOpacity(0.3),
            )
          ],
          color: AppColors.whiteFe,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            IconButton(
              splashRadius: 0.1,
              icon: const FaIcon(
                Icons.add,
                color:  AppColors.primaryBlue,
              ),
              onPressed: () {
                widget.onAddPressed();

              },
            ),
            const Text(
             'add new',
              maxLines: 1,
              style: TextStyle(
                fontSize: 8,
                overflow: TextOverflow.ellipsis,
                color: AppColors.primaryBlue,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.address.length+1,
        itemBuilder: (_, index) => item(index==widget.address.length?Address("name", false, Icons.add,0,0,""):widget.address[index], index),
      ),
    );
  }
}