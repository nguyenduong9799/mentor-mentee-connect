import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/root_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/custom_dialog.dart';
import '';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentor_mentee_connecting/Model/DAO/AccountDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Service/analytic_service.dart';
import 'package:mentor_mentee_connecting/Service/push_notification_service.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  late AccountDAO dao = AccountDAO();
  late String verificationId;
  late AnalyticsService _analyticsService;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late AccountDTO userInfo;

  LoginViewModel() {
    _analyticsService = AnalyticsService.getInstance()!;
  }
  // Future<void> _signInWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final googleAuth = await googleUser?.authentication;

  //     if (googleAuth != null) {
  //       // Create a new credential
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       // Once signed in, return the UserCredential
  //       await _auth.signInWithCredential(credential);
  //       // UserCredential user = await _auth.signInWithCredential(credential);
  //       User userToken = FirebaseAuth.instance.currentUser!;
  //       final idToken = await userToken.getIdToken();
  //       // log(idToken);
  //       AccountDAO().login(idToken);
  //       final userDTO = dao.login(idToken);
  //       // await PushNotificationService.getInstance()!.init();

  //       await _analyticsService.setUserProperties(userDTO as AccountDTO);
  //       // await Get.find<RootViewModel>().startUp();
  //       Get.offAllNamed(RouteHandler.NAV);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     await CustomDialogBox(title: '${e.message}');
  //     print(e.message);
  //   } finally {}
  // }

  Future<void> signInWithGoogle() async {
    try {
      setState(ViewStatus.Loading);
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // Once signed in, return the UserCredential
        await _auth.signInWithCredential(credential);
        // UserCredential user = await _auth.signInWithCredential(credential);
        User userToken = FirebaseAuth.instance.currentUser!;
        final idToken = await userToken.getIdToken();
        final fcmToken = await FirebaseMessaging.instance.getToken();
        log(idToken.toString());
        log(fcmToken.toString());
        userInfo = await dao.login(idToken, fcmToken!);
        await _analyticsService.setUserProperties(userInfo);
        if (userInfo != null) {
          await Get.find<RootViewModel>().startUp();
          Get.rawSnackbar(
              message: "Đăng nhập thành công!!",
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 32),
              borderRadius: 8);

          await Get.offAndToNamed(RouteHandler.NAV);
        }
      }
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } on FirebaseAuthException catch (e) {
      // setState(() {
      log(e.message!);
      // });
      setState(ViewStatus.Completed);
      // print(error);
    }
  }
}
