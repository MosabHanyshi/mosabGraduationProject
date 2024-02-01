import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/utils/constants.dart';

class TopHeader extends StatefulWidget {
  const TopHeader({required this.onPressed,required this.selectedTimeline, super.key});

  final Future<void>? Function(int index) onPressed;
  final int selectedTimeline;

  @override
  State<TopHeader> createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  @override
  Widget build(BuildContext context) {
    List<Widget> head = [];
    for (int i = 0; i < 3; ++i) {
      head.add(Flexible(
        child: InkWell(
          onTap: () async {
            await widget.onPressed.call(i);
          },
          child: Text(
            AppConstant.timelines[i],
            style: TextStyle(
                fontSize: i == widget.selectedTimeline ? 20 : 14,
                color: Colors.black54),
          ),
        ),
      ));
    }

    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: head
        ));
  }
}
