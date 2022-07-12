import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/ViewModel/startup_viewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StartUpViewModel>(
      model: StartUpViewModel(),
      child: ScopedModelDescendant<StartUpViewModel>(
          builder: (context, child, model) {
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_blue.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/icons/logo.png"),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Mentee Connect",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
        ;
      }),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final String title;
  const LoadingScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: 250.0,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LoadingBean(),
              SizedBox(height: 16),
              Text(
                this.title,
                style: Get.theme.textTheme.headline1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
