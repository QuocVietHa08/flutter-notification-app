import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final Function handleClickEvent;

  const TabItem(
      {Key? key,
      required this.text,
      required this.icon,
      required this.isSelected,
      required this.handleClickEvent
      });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color:  Colors.white,
            ),
            Text(
              text,
              style: TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            )
          ],
        ),
      ),
      onTap: () {
        handleClickEvent();
      },
    );
  }
}
