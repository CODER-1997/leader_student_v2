 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/custom_widgets/emptiness.dart';
import '../../../constants/theme.dart';

class Grades extends StatelessWidget {

  final List grades;
  Grades({required this.grades});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baholar'),
      ),
      backgroundColor: homePagebg,
      body: grades.isNotEmpty ? ListView.builder(
          itemCount: grades.length,
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.all( 4),
              decoration: BoxDecoration(
                color: Colors.white
              ),
              padding: EdgeInsets.all(8),
              child: ListTile(
                title: Text("${grades[i]['date'] + " " + grades[i]['time']}",style: TextStyle(
                  color: Colors.black,
                  fontSize: 12
                ),),
                subtitle: Text("${grades[i]['grade']} %",style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900
                ),),
              ),
            );
          })
            : Emptiness(
        title: 'Hali baholanmagan'),
    );
  }
}
