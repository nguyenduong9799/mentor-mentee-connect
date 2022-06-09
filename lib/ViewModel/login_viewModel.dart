import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Widgets/custom_dialog.dart';
import '';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentor_mentee_connecting/Model/DAO/AccountDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Service/analytic_service.dart';
import 'package:mentor_mentee_connecting/Service/push_notification_service.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  late AccountDAO dao = AccountDAO();
  late String verificationId;
  late AnalyticsService _analyticsService;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late AccountDTO user;

  LoginViewModel() {
    _analyticsService = AnalyticsService.getInstance()!;
  }

  // Future<AccountDTO> signIn(UserCredential userCredential,
  //     [String method = "phone"]) async {
  //   try {
  //     // lay thong tin user tu firebase

  //     await _analyticsService.logLogin(method);
  //     // TODO: Thay uid = idToken
  //     String token = await userCredential.user.getIdToken();
  //     final userInfo = await dao.login(token);
  //     await PushNotificationService.getInstance().init();

  //     await _analyticsService.setUserProperties(userInfo);
  //     return userInfo;
  //   } catch (e) {
  //     bool result = await showErrorDialog();
  //     if (result) {
  //       await signIn(userCredential);
  //     } else
  //       setState(ViewStatus.Error);
  //   }
  // }

  Future<void> signInWithGoogle() async {
    try {
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
        // log(idToken);
        AccountDAO().login(idToken);
        final userDTO = dao.login(idToken);
        // await PushNotificationService.getInstance()!.init();

        await _analyticsService.setUserProperties(userDTO as AccountDTO);
        // await Get.find<RootViewModel>().startUp();
        Get.offAllNamed(RouteHandler.NAV);
      }
    } on FirebaseAuthException catch (e) {
      await CustomDialogBox(title: '${e.message}');
      print(e.message);
    } finally {}
  }

  // Future<void> onSignInWithGmail() async {
  //   try {
  //     final authCredential = await AuthService().signInWithGoogle();
  //     if (authCredential == null) return;

  //     showLoadingDialog();
  //     await Get.find<RootViewModel>().startUp();
  //     return Get.offAllNamed(RouteHandler.NAV);
  //   } on FirebaseAuthException catch (e) {
  //     await showStatusDialog(
  //         "assets/images/global_error.png", "Error", e.message);
  //   } finally {
  //     hideDialog();
  //   }
  // }
}
