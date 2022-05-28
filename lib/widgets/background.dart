import 'package:flutter/material.dart';

class BackgroudCurveWidget extends StatelessWidget {
  const BackgroudCurveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(64),
            bottomRight: Radius.circular(64),
          ),
        ),
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFFFB300),
            Color(0xFFFF6F00),
          ],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 16.0, left: 20.0),
        child: Text(
          'Find Close Contacts',
          style: TextStyle(
            // fontFamily: 'Murray Hill',
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
