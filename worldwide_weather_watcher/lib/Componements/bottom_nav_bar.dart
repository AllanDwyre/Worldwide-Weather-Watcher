// https://www.youtube.com/watch?v=U4LYZMZSxjk
import 'package:flutter/material.dart';
import '../constants.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    List<IconData> iconData = <IconData>[
      Icons.home_outlined,
      Icons.show_chart_rounded,
      Icons.archive_outlined
    ];
    return Align(
      alignment: const Alignment(0, 1),
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding / 2),
        width: 270,
        height: 54,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              offset: const Offset(0, 4),
              blurRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home_outlined),
              // color: kPrimaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.show_chart_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.archive_outlined),
            ),
          ],
        ),
      ),
    );
  }
}



// ListView.builder(
//             itemCount: iconData.length,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = index;
//                     });
//                   },
//                   child: AnimatedContainer(
//                     width: 32,
//                     duration: const Duration(milliseconds: 500),
//                     decoration: BoxDecoration(
//                       color:
//                           index == selectedIndex ? Colors.black : Colors.white,
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: Icon(
//                       iconData[index],
//                       size: 25,
//                       color:
//                           index == selectedIndex ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//               );
//             }),