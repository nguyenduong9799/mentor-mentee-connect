import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Model/DAO/AccountDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Service/firebase_auth.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';
import 'package:mentor_mentee_connecting/View/home.dart';
import 'package:mentor_mentee_connecting/View/root_app.dart';
import 'package:mentor_mentee_connecting/ViewModel/login_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/custom_image2.dart';
import 'package:mentor_mentee_connecting/theme/color.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscureText = true;
  bool isLoading = false;
  AccountDAO? dao;
  String error = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  // AuthService service = AuthService();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: LoginViewModel(),
      child: Scaffold(
        body: getBody(),
      ),
    );
  }

  getBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.fromLTRB(0, 150, 0, 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: 180,
              height: 180,
              child: CustomImage2(
                "https://cdn-icons-png.flaticon.com/512/3820/3820331.png",
                bgColor: appBgColor,
                isSVG: false,
                radius: 5,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Mentor Mentee Connect",
              style: TextStyle(color: secondary, fontSize: 28),
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Container(child: ScopedModelDescendant<LoginViewModel>(
              builder: (context, child, LoginViewModel model) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isLoading
                    ? Container(
                        color: Colors.grey[200],
                        height: 60,
                        width: 240,
                      )
                    : SizedBox(
                        width: 240,
                        height: 60,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            // AuthService().signInWithGoogle();
                            // _signInWithGoogle();

                            model.signInWithGoogle();
                          },
                        ),
                      ),
              ),
            );
          })),
        ],
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    setIsLoading();

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
        // AccountDTO? userInfo = await dao?.login(idToken);
        // log(userInfo.toString());
        log(idToken.toString());

        Response response = await request
            .post("authenticate/login", data: {"idToken": idToken});
        final user = response.data["data"];
        final userDTO = AccountDTO.fromJson(user);
        log(userDTO.toJson().toString());
        final accessToken = user["accessToken"] as String;
        if (accessToken != null) Get.toNamed(RouteHandler.NAV);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = '${e.message}';
      });
      print(error);
    } finally {
      setIsLoading();
    }
  }
}
