import 'package:flutter/material.dart';
import '../../../constants.dart';

class SideNavWidget extends StatefulWidget {
  const SideNavWidget({Key? key}) : super(key: key);

  @override
  _SideNavWidgetState createState() => _SideNavWidgetState();
}

class _SideNavWidgetState extends State<SideNavWidget> {
  int selectedIndex = 0;
  List<double> pos = <double>[-.75 + .085, -.25 + .085, .25 - .085, .75 - .085];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(-1, .6),
      child: Container(
        margin: const EdgeInsets.only(left: kDefaultPadding / 2),
        width: 22,
        height: 227,
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(.6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.25),
              blurRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  circleSidebar,
                  circleSidebar,
                  circleSidebar,
                  circleSidebar
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, pos[selectedIndex]),
              child: dotSidebar,
            )
          ],
        ),
      ),
    );
  }
}

Widget circleSidebar = Container(
  height: 15,
  width: 15,
  decoration: BoxDecoration(
      color: kPrimaryColor.withOpacity(.7),
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Colors.black.withOpacity(.2))),
);

Widget dotSidebar = Container(
  height: 15 / 2,
  width: 15 / 2,
  decoration: BoxDecoration(
    color: Colors.black.withOpacity(.5),
    borderRadius: BorderRadius.circular(50),
    border: Border.all(
      color: Colors.black.withOpacity(.2),
    ),
  ),
);


// Padding(
//           padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
//           child: ListView.builder(
//               itemCount: 4,
//               itemBuilder: (context, index) {
//                 return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: pointSidebar);
//               }),
//         ),

// Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [pointSidebar, pointSidebar, pointSidebar, pointSidebar],
//         ),