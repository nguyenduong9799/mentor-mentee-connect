import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/View/course_detail.dart';
import 'package:mentor_mentee_connecting/View/home.dart';
import 'package:mentor_mentee_connecting/View/update.dart';
import 'package:mentor_mentee_connecting/View/update_course.dart';
import 'package:mentor_mentee_connecting/setup.dart';

import 'Constant/route_constraint.dart';
import 'Model/DTO/AccountDTO.dart';
import 'Utils/pageNavigation.dart';
import 'Utils/request.dart';
import 'View/onboard.dart';
import 'View/root_app.dart';
import 'View/session_detail.dart';
import 'View/sign_in.dart';
import 'View/start_up.dart';
import 'theme/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await setUp();
  createRouteBindings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentor Mentee Connecting',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RouteHandler.LOGIN:
            return ScaleRoute(page: SignIn());
          case RouteHandler.ONBOARD:
            return ScaleRoute(page: OnBoardScreen());
          case RouteHandler.HOME:
            return CupertinoPageRoute(
                builder: (context) => HomePage(), settings: settings);

          case RouteHandler.COURSE_DETAILS:
            return CupertinoPageRoute(
                builder: (context) =>
                    CourseDetails(data: settings.arguments as CourseDTO),
                settings: settings);
          case RouteHandler.SESSION_DETAILS:
            return CupertinoPageRoute(
                builder: (context) =>
                    SessionDetails(data: settings.arguments as SessionDTO),
                settings: settings);
          case RouteHandler.UPDATE:
            return CupertinoPageRoute(
                builder: (context) =>
                    Update(user: settings.arguments as AccountDTO),
                settings: settings);
          case RouteHandler.UPDATE_COURSE:
            return CupertinoPageRoute(
                builder: (context) =>
                    UpdateCourse(course: settings.arguments as CourseDTO),
                settings: settings);
          case RouteHandler.NAV:
            return CupertinoPageRoute(
                builder: (context) => RootApp(), settings: settings);
          default:
            return CupertinoPageRoute(
                builder: (context) => RootApp(), settings: settings);
        }
      },
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: StartUpView(),
    );
  }
}
