import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/utils/data.dart';
import 'package:mentor_mentee_connecting/widgets/category_box.dart';
import 'package:mentor_mentee_connecting/widgets/feature_item.dart';
import 'package:mentor_mentee_connecting/widgets/notification_box.dart';
import 'package:mentor_mentee_connecting/widgets/recommend_item.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return ScopedModel(
      model: Get.find<AccountViewModel>(),
      child: ScopedModelDescendant<AccountViewModel>(
        builder: (context, child, model) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Xin chào !",
                        style: TextStyle(
                          color: labelColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      model.currentUser.fullName ?? "User",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
                NotificationBox(
                  notifiedNumber: 1,
                  onTap: () {},
                )
              ],
            ),
          );
        },
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Text("Your Courses",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                )),
          ),
          getRecommend(),
        ]),
      ),
    );
  }

  int selectedCollection = 0;
  getCategories() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              categories.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CategoryBox(
                    selectedColor: Colors.white,
                    data: categories[index],
                    onTap: () {
                      setState(() {
                        selectedCollection = index;
                      });
                    },
                  )))),
    );
  }

  getFeature() {
    return ScopedModel<CourseViewModel>(
        model: Get.find<CourseViewModel>(),
        child: ScopedModelDescendant<CourseViewModel>(
          builder: (context, child, model) {
            List<CourseDTO>? currentCourse = model.listCourse;
            if (currentCourse == null)
              return SizedBox(
                height: 30,
              );
            else
              return CarouselSlider(
                  options: CarouselOptions(
                    height: 280,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    viewportFraction: .75,
                  ),
                  items: List.generate(
                      currentCourse.length,
                      (index) => FeatureItem(
                          onTap: () {}, data: currentCourse[index])));
          },
        ));
  }

  getRecommend() {
    return ScopedModel<CourseViewModel>(
      model: Get.find<CourseViewModel>(),
      child: ScopedModelDescendant<CourseViewModel>(
          builder: (context, child, model) {
        List<CourseDTO>? currentCourse = model.listCourse;
        if (currentCourse == null || currentCourse.length == 0)
          return Center(
              child: Text(
            "Hiện tại chưa có khóa học nào",
            style: TextStyle(
                color: primary, fontSize: 20, fontWeight: FontWeight.w700),
          ));
        else
          return Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 8),
              child: Column(
                  children: List.generate(
                      currentCourse.length,
                      (index) => Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: RecommendItem(
                              onTap: () {},
                              data: currentCourse[index],
                            ),
                          ))),
            ),
          );
      }),
    );
  }
}
