import 'package:flutter/material.dart';
import '../../../constants.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.color = kPrimaryColor,
    Key? key,
  }) : super(key: key);
  final double top;
  final double left;
  final double right;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, top, right, 0),
      child: Divider(
        color: color,
      ),
    );
  }
}
