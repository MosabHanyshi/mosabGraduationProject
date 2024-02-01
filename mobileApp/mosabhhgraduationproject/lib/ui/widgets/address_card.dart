import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/data/model/Address.dart';

class AdressCard extends StatefulWidget {
  const AdressCard({super.key,
    required this.address,});

  final Address address;

  @override
  State<AdressCard> createState() => _AdressCardState();
}

class _AdressCardState extends State<AdressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        elevation: 3,
        child: SizedBox(
            height: 150,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(widget.address.icon,size:50),
                  ),
                  Text(
                    widget.address.name??"",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
