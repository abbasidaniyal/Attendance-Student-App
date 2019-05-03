import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'attendance_page.dart';
import '../scoped_models/student.dart';
import '../widget/drawer.dart';
import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sId;
  String ip;
  Future<String> macAddress;

  GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    Connectivity().getWifiIP().then((onValue) {
      ip = onValue;
      print(ip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mark Attendance"),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Form(
            key: _key,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Student ID",
                    ),
                    onChanged: (value) {
                      setState(() {
                        sId = value;
                      });
                    },
                  ),
                  ScopedModelDescendant<StudentModel>(
                    builder: (context, child, model) {
                      return RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          model.login(sId, ip).then((status) {
                            print("STATUS :" + status.toString());

                            if (status && model.attendaceLive) {
                              return Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return AttendancePage();
                                  },
                                ),
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Invalid Student IP or not connected to college wifi"),
                                    );
                                  });
                            }
                          });
                        },
                      );
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
