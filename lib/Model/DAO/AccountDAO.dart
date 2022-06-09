import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Service/push_notification_service.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';
import 'package:mentor_mentee_connecting/Utils/shared_pref.dart';
import 'package:mentor_mentee_connecting/View/login.dart';

import 'BaseDAO.dart';

// TODO: Test Start_up Screen + FCM TOken

class AccountDAO extends BaseDAO {
  Future<AccountDTO> login(String idToken) async {
    try {
      String? fcmToken;

      fcmToken = (await PushNotificationService.getInstance().getFcmToken());

      Response response =
          await request.post("authenticate/login", data: {"idToken": idToken});
      final user = response.data["data"];
      final userDTO = AccountDTO.fromJson(user);
      // log(userDTO.toJson().toString());
      final accessToken = user["accessToken"] as String;

      // set access token
      // print("accessToken    $accessToken");
      requestObj.setToken = accessToken;
      setToken(accessToken);
      return userDTO;
    } catch (e) {}
    return AccountDTO(fullName: "Default Name");
  }

  Future<bool> isUserLoggedIn() async {
    final isExpireToken = await expireToken();
    final token = await getToken();
    if (isExpireToken) return false;
    if (token != null) requestObj.setToken = token;
    return token != null;
  }

  Future<AccountDTO> getUser() async {
    Response response = await request.get("me");
    // set access token
    final user = response.data["data"];
    return AccountDTO.fromJson(user);
    // return AccountDTO(uid: idToken, name: "Default Name");
  }

  Future<String> getRefferalMessage(String refferalCode) async {
    try {
      Response response =
          await request.post("/me/refferal", data: "'$refferalCode'");
      // set access token
      return response.data['message'];
    } catch (e) {
      throw e;
    }

    // return AccountDTO(uid: idToken, name: "Default Name");
  }

  // Future<void> sendFeedback(String feedBack) async {
  //   await request.post("/me/feedback", data: "'$feedBack'");
  // }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  // Future<void> logOut() async {
  //   await AuthService().signOut();
  //   String fcmToken = await PushNotificationService.getInstance().getFcmToken();
  //   await request.post("logout", data: {"fcm_token": fcmToken});
  // }

  Future<AccountDTO> updateUser(AccountDTO updateUser) async {
    var dataJson = updateUser.toJson();
    Response res = await request.put("me", data: dataJson);
    return AccountDTO.fromJson(res.data["data"]);
  }
}
