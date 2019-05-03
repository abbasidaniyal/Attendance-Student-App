import 'package:flutter/material.dart';
import '../widget/drawer.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/student.dart';

class SubjectAttendance extends StatelessWidget {
  int selectedSubjectId;
  double attendance;

  SubjectAttendance(this.selectedSubjectId, this.attendance);

  @override
  Widget build(BuildContext context) {
    StudentModel model = ScopedModel.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Subject Attendance"),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text(
            "Your Attendance in ${model.checkAttendanceStudent.subjects.firstWhere((a) {
          return a.sID == selectedSubjectId;
        }).subjectName} is $attendance",textScaleFactor: 1.3,),
      ),
    );
  }
}
