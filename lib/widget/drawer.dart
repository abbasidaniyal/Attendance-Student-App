import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/check_attendance_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: GestureDetector(
              child: Text("Mark Attendance"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: GestureDetector(
              child: Text("Check Attendance"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CheckAttendance();
                }));
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          
        ],
      ),
    );
  }
}
