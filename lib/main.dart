import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/View/course_detail.dart';
import 'package:mentor_mentee_connecting/View/home.dart';
import 'package:mentor_mentee_connecting/View/login.dart';
import 'package:mentor_mentee_connecting/setup.dart';
import 'Constant/route_constraint.dart';
import 'Utils/pageNavigation.dart';
import 'Utils/request.dart';
import 'View/onboard.dart';
import 'View/root_app.dart';
import 'View/sign_in.dart';
import 'View/start_up.dart';
import 'theme/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
