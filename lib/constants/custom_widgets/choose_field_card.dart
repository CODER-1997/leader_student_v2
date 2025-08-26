import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChooseField extends StatelessWidget {
  final String title;
  final String top_title;
  final String img;
  final Color color1;
  final Color color2;

  ChooseField(
      {required this.title,
      required this.img,
      required this.color1,
      required this.color2,
      required this.top_title,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment(-1.00, -0.00),
          end: Alignment(1, 0),
          colors: [color1, color2],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${top_title}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '${title}',
                  style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  child: Image.asset(
            'assets/${img}.png',
            fit: BoxFit.fill,
          )))
        ],
      ),
    );
  }
}
