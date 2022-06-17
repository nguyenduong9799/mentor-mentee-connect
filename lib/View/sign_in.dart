import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/ViewModel/login_viewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: LoginViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg-signin.png"),
                  fit: BoxFit.fill),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 240, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Chào mừng bạn quay trở lại!",
                    style: TextStyle(
                      fontFamily: 'Nunito-Black',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Đăng nhập và tận hưởng những ưu đãi yêu thích của bạn!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Nunito-SemiBold',
                        color: labelColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 40),
                  ScopedModelDescendant<LoginViewModel>(
                    builder: (context, child, LoginViewModel model) {
                      return InkWell(
                        onTap: () {
                          model.signInWithGoogle();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: secondary.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          width: 280,
                          height: 48,
                          alignment: Alignment.center,
                          child: Text(
                            "Đăng nhập bằng Gmail",
                            style: TextStyle(
                                fontFamily: 'Nunito-SemiBold',
                                color: appBgColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ));
  }
}
