import 'package:flutter/material.dart';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/student.dart';
import './home_page.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ScopedModelDescendant<StudentModel>(
          builder: (context, child, StudentModel model) {
            return Column(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Text("Welcome ${model.student.name}"),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    child: Text(
                        "Mark Present for ${model.liveAttendanceSubject.subjectName}"),
                    onPressed: () {
                      model
                          .sendAttendance(model.student.sID,
                              model.liveAttendanceSubject.sID)
                          .then((status) {
                        if (status) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Attendance"),
                                  content: Text("You have been marked present"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Continue"),
                                      onPressed: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return HomePage();
                                        }));   
                                      },
                                    )
                                  ],
                                );
                              });
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Error"),
                          ));
                        }
                      });
                    },
                  ),
                )
              ],
            );
          },
        ));
  }
}
