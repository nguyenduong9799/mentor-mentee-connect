import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/UserWallet.dart';
import 'package:mentor_mentee_connecting/Service/push_notification_service.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';
import 'package:mentor_mentee_connecting/Utils/shared_pref.dart';

import 'BaseDAO.dart';

// TODO: Test Start_up Screen + FCM TOken

class AccountDAO extends BaseDAO {
  Future<AccountDTO> login(String idToken, String fcmToken) async {
    try {
      Response response = await request.post("authenticate/login",
          data: {"idToken": idToken, "fcmToken": fcmToken});
      final user = response.data["data"];
      final userDTO = AccountDTO.fromJson(user);
      final accessToken = user["accessToken"] as String;

      // set access token
      // print("accessToken    $accessToken");
      requestObj.setToken = accessToken;
      setToken(accessToken);
      return userDTO;
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> isUserLoggedIn() async {
    final isExpireToken = await expireToken();
    final token = await getToken();
    if (isExpireToken) return false;
    if (token != null) requestObj.setToken = token;
    return token != null;
  }

  Future<AccountDTO> getUser() async {
    Response response = await request.get("users/me");
    // set access token
    final user = response.data;
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
    Response res = await request.put("users/me", data: dataJson);
    return AccountDTO.fromJson(res.data);
  }

  Future<UserWallet> linkAccountToWallet(String phone) async {
    try {
      Response response =
          await request.post("wallet", data: {'phoneNumber': phone});
      // set access token
      return UserWallet.fromJson(response.data['data']);
    } catch (e) {
      throw e;
    }
  }

  Future<UserWallet> getUserWallet(String phone) async {
    Response response = await request.get('wallet/$phone');
    // set access tokenF
    final user = response.data;
    return UserWallet.fromJson(user);
    // return AccountDTO(uid: idToken, name: "Default Name");
  }
}
