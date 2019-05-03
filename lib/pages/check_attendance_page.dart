import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/student.dart';
import '../widget/drawer.dart';
import './subject_attendance.dart';

class CheckAttendance extends StatefulWidget {
  @override
  _CheckAttendanceState createState() => _CheckAttendanceState();
}

class _CheckAttendanceState extends State<CheckAttendance> {
  String sId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text("Check Attendance"),
        ),
        body: Container(
          child: Center(
            child: Form(
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
                          model.getAttendance(sId).then(
                            (status) {
                              print("STATUS :" + status.toString());

                              if (status) {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return ListView.builder(
                                        itemCount: model.checkAttendanceStudent
                                            .subjects.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.all(10.0),
                                            child: GestureDetector(
                                            child: Text(model
                                                .checkAttendanceStudent
                                                .subjects[index]
                                                .subjectName,textScaleFactor: 1.3,),
                                            onTap: () {
                                              model
                                                  .getAttendanceofStudent(
                                                      model
                                                          .checkAttendanceStudent
                                                          .sID,
                                                      model
                                                          .checkAttendanceStudent
                                                          .subjects[index]
                                                          .sID)
                                                  .then((attendance) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return SubjectAttendance(
                                                      model
                                                          .checkAttendanceStudent
                                                          .subjects[index]
                                                          .sID,
                                                      attendance);
                                                }));
                                              });
                                            },
                                          ),
                                          );
                                        },
                                      );
                                    });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Invalid Student IP or not connected to college wifi"),
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            )),
          ),
        ));
  }
}
