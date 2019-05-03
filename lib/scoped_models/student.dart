import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/student_model.dart';
import '../models/subject_model.dart';

class StudentModel extends Model {
  Student student, checkAttendanceStudent;
  bool isVerified = false;
  Subject liveAttendanceSubject, selectedAttendanceCheckSubject;
  bool attendaceLive = false;
  double attendancePercentage = 0.0;
  bool checkAttendanceVerification = false;

  Future<bool> login(String sId, String ip) async {
    await http
        .get(
            "http://13.233.160.117:8000/students/student-subject/${int.parse(sId)}")
        .then(
      (http.Response res) {
        if (res.statusCode == 200 && res.body.isNotEmpty) {
          var a = json.decode(res.body)[0];
          print(a);

          if (a["students_ip"].toString().contains(ip)) {
            print("IP Verified");

            print("TEST" + a["student_subject"].toList().length.toString());
            for (var i = 0; i < a["student_subject"].toList().length; i++) {
              if (!a["student_subject"][i]["is_live"]
                  .toString()
                  .contains("NL")) {
                attendaceLive = true;
                isVerified = true;
                String c = a["student_subject"][i]["subject_name"];
                String sid = a["student_subject"][i]["subject_id"].toString();
                print(c);
                liveAttendanceSubject =
                    Subject(subjectName: c, sID: int.parse(sid));

                break;
              }
            }

            student = Student(
              ip: a["ip"],
              sID: int.parse(sId),
              name: a["first_name"] + a["last_name"],
              subjects: List.generate(
                a["student_subject"].toList().length,
                (d) {
                  var temp = a["student_subject"][d];
                  Subject sub = Subject(
                    subjectName: temp["subject_name"],
                    sID: temp["subject_id"],
                    isLive: temp["is_live"],
                    subjectTeacherID: temp["subject_teacher"],
                  );
                  return sub;
                },
              ),
            );
            print(student);
            notifyListeners();
            print("REACHING 3");
          }
        } else {
          isVerified = false;
        }
      },
    );

    return isVerified;
  }

  Future<bool> sendAttendance(int studID,int subjID) async {
    bool attendanceStatus=false;
    await http.post("http://13.233.160.117:8000/students/attendance}", body: {
      "Name": student.name,
      "Subject_Code": liveAttendanceSubject.sID.toString(),
      "Status": "P",
      "Date": DateTime.now().toString()
    }).then((res) {
      if (res.statusCode==200) {
        attendanceStatus=true;
        notifyListeners();
        
      }

    });
    return attendanceStatus;
  }

  Future<bool> getAttendance(String sID) async {
   await http
        .get(
            "http://13.233.160.117:8000/students/student-subject/${int.parse(sID)}")
        .then((res) {
      print(res.body);
      if (res.statusCode == 200 && res.body.isNotEmpty) {
        var a = json.decode(res.body)[0];
        checkAttendanceStudent = Student(
          ip: a["ip"],
          sID: int.parse(sID),
          name: a["first_name"] + a["last_name"],
          subjects: List.generate(
            a["student_subject"].toList().length,
            (d) {
              var temp = a["student_subject"][d];
              Subject sub = Subject(
                subjectName: temp["subject_name"],
                sID: temp["subject_id"],
                isLive: temp["is_live"],
                subjectTeacherID: temp["subject_teacher"],
              );
              return sub;
            },
          ),
        );
        checkAttendanceVerification = true;
        print(checkAttendanceVerification);
        notifyListeners();
      } else {
        checkAttendanceVerification = false;
      }
    });

    return checkAttendanceVerification;
  }

  Future<double> getAttendanceofStudent(int studID, int subID) async {
    http
        .get(
            "http://13.233.160.117:8000/students/attendance-of-student/$studID/of-subject/$subID/")
        .then((res) {
      if (res.statusCode == 200 && res.body.isNotEmpty) {
        var temp = json.decode(res.body);
        print(temp);
        // attendancePercentage = temp["attendance_percentage"];
      }
    });

    return attendancePercentage;
  }
}
