import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';
import 'package:mentor_mentee_connecting/Utils/format_time.dart';
import 'package:mentor_mentee_connecting/View/login.dart';
import 'package:mentor_mentee_connecting/View/sign_in.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/theme/color.dart';
import 'package:mentor_mentee_connecting/utils/data.dart';
import 'package:mentor_mentee_connecting/widgets/custom_image.dart';
import 'package:mentor_mentee_connecting/widgets/setting_box.dart';
import 'package:mentor_mentee_connecting/widgets/setting_item.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late User user;
  late TextEditingController controller;

  String? photoURL;

  bool showSaveButton = false;
  bool isLoading = false;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    log(user.toString());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  /// Map User provider data into a list of Provider Ids.
  List get userProviders => user.providerData.map((e) => e.providerId).toList();

  Future updateDisplayName() async {
    await user.updateDisplayName(controller.text);

    setState(() {
      showSaveButton = false;
    });

    // ignore: use_build_context_synchronously
    // ScaffoldSnackbar.of(context).show('Name updated');
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    await Get.find<AccountViewModel>().fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: appBgColor,
            pinned: true,
            snap: true,
            floating: true,
            title: getHeader()),
        SliverToBoxAdapter(child: getBody())
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return ScopedModel(
  //     model: Get.find<AccountViewModel>(),
  //     child: Scaffold(
  //       appBar: AppBar(backgroundColor: appBgColor, title: getHeader()),
  //       backgroundColor: appBgColor,
  //       body: SafeArea(
  //           child: RefreshIndicator(
  //               key: _refreshIndicatorKey,
  //               onRefresh: _refresh,
  //               child: getBody())),
  //     ),
  //   );
  // }

  getHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tài khoản",
            style: TextStyle(
                color: textColor, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return ScopedModel<AccountViewModel>(
      model: Get.find<AccountViewModel>(),
      child: ScopedModelDescendant<AccountViewModel>(
          builder: (context, child, model) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      final photoURL = await getPhotoURLFromUser();

                      if (photoURL != null) {
                        await user.updatePhotoURL(photoURL);
                      }
                    },
                    child: CustomImage(
                      model.currentUser.imageUrl ?? "no-data.png",
                      width: 80,
                      height: 80,
                      radius: 20,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.currentUser.fullName ?? "User",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        model.currentUser.email ?? "User",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        formatDateType(model.currentUser.dayOfBirth ??
                            "1974-03-20 00:00:00.000"),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: SettingBox(
                      title: (Get.find<CourseViewModel>()
                                  .listCourse!
                                  .length
                                  .toString() ??
                              "0") +
                          " Courses",
                      icon: "assets/icons/work.svg",
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: SettingBox(
                      title: formatBean(model.wallet.point ?? 0) + " Bean",
                      icon: "assets/icons/wallet.svg",
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: SettingBox(
                      title: "4.8",
                      icon: "assets/icons/star.svg",
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(children: [
                  SettingItem(
                    title: "Cập nhật thông tin",
                    leadingIcon: "assets/icons/setting.svg",
                    bgIconColor: blue,
                    onTap: () async {
                      dynamic result = await Get.toNamed(RouteHandler.UPDATE,
                          arguments: model.currentUser);
                      if (result != null) {
                        if (result) {
                          await model.fetchUser();
                        }
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Divider(
                      height: 0,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  SettingItem(
                    title: "Lịch sử giao dịch",
                    leadingIcon: "assets/icons/wallet.svg",
                    bgIconColor: green,
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Divider(
                      height: 0,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  SettingItem(
                    title: "Chứng chỉ",
                    leadingIcon: "assets/icons/bookmark.svg",
                    bgIconColor: primary,
                    onTap: () {
                      Get.toNamed(RouteHandler.CERTIFICATE);
                    },
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(children: [
                  SettingItem(
                    title: "Notification",
                    leadingIcon: "assets/icons/bell.svg",
                    bgIconColor: purple,
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Divider(
                      height: 0,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  SettingItem(
                    title: "Privacy",
                    leadingIcon: "assets/icons/shield.svg",
                    bgIconColor: orange,
                    onTap: () {},
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(children: [
                  SettingItem(
                    title: "Đăng xuất",
                    leadingIcon: "assets/icons/logout.svg",
                    bgIconColor: darker,
                    onTap: () {
                      _signOut();
                    },
                  ),
                ]),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Get.offAllNamed(RouteHandler.LOGIN);
  }

  Future<String?> getPhotoURLFromUser() async {
    String? photoURL;

    // Update the UI - wait for the user to enter the SMS code
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('New image Url:'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            OutlinedButton(
              onPressed: () {
                photoURL = null;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                photoURL = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
          ),
        );
      },
    );

    return photoURL;
  }
}
