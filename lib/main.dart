import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/splash_screen_page.dart';
import './scoped_models/student.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: StudentModel(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: WelcomePage()),
    );
  }
}
