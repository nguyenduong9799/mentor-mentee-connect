import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Model/DAO/AccountDAO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/shared_pref.dart';

class OnBoardScreen extends StatefulWidget {
  OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

PageDecoration pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
  bodyTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  imagePadding: EdgeInsets.zero,
);

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      PageViewModel(
        title: "Đa dạng khóa học",
        body: "Đầy đủ các khóa học cho các bạn lựa chọn.",
        image: _buildImage('onboard-welcome-bg.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Mentor tâm huyết",
        body: "Những mentor chất lượng giúp ban tiếp thu thêm nhiều kiến thức.",
        image: _buildImage('onboard-earn-points-bg.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Tích thật nhiều điểm",
        body: "Tích góp thật nhiều điểm và đổi được những phần quà hay ho nhá.",
        image: _buildImage('onboard_rewards_bg.png'),
        decoration: pageDecoration,
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: pages,
          onDone: () => _onIntroEnd(),
          onSkip: () => _onIntroEnd(), // You can override onSkip callback
          showSkipButton: true,
          next: const Icon(
            Icons.arrow_forward,
            color: primary,
          ),
          skip: Text(
            'Bỏ qua',
            style: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.bold, color: primary),
          ),
          done: Text('Xong',
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold, color: primary)),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.grey,
            activeColor: primary,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }

  void _onIntroEnd() async {
    // set pref that first onboard is false
    AccountDAO _accountDAO = AccountDAO();
    var hasLoggedInUser = await _accountDAO.isUserLoggedIn();
    await setIsFirstOnboard(false);
    if (hasLoggedInUser) {
      // await Get.find<RootViewModel>().startUp();
      Get.offAndToNamed(RouteHandler.NAV);
    } else {
      Get.offAndToNamed(RouteHandler.LOGIN);
    }
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName',
          fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
      alignment: Alignment.bottomCenter,
    );
  }
}
