import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MajorDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/data.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/major_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/course_status_item.dart';
import 'package:mentor_mentee_connecting/Widgets/notification_box.dart';
import 'package:mentor_mentee_connecting/Widgets/recommend_item.dart';
import 'package:mentor_mentee_connecting/Widgets/subject_filter.dart';
import 'package:mentor_mentee_connecting/widgets/custom_textfield.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              bottom: getSearchBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => getSearchCourses(),
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
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Xin chào  ",
                        style: TextStyle(
                          color: labelColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )),
                    Text(
                      model.currentUser.fullName ?? "User",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )),
                // NotificationBox(
                //   notifiedNumber: 1,
                //   onTap: () {},
                // )
              ],
            ),
          );
        },
      ),
    );
  }

  getHeader() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(0, 40, 0, 4),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Search Course",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ],
        ));
  }

  getSearchBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(88),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(
                "Khóa học của bạn",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            buildCategory()
          ],
        ));
  }

  getSearchCourses() {
    return ScopedModel<CourseViewModel>(
      model: Get.find<CourseViewModel>(),
      child: ScopedModelDescendant<CourseViewModel>(
          builder: (context, child, model) {
        List<CourseDTO>? currentCourse = model.listCourse;
        if (currentCourse == null || currentCourse.length == 0)
          return Container(
            padding: EdgeInsets.only(top: 100),
            child: Center(
                child: Text(
              "Hiện tại chưa có khóa học ứng với trạng thái này",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primary, fontSize: 20, fontWeight: FontWeight.w700),
            )),
          );
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
                            padding: EdgeInsets.only(bottom: 12),
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

  int selectedCategoryIndex = 0;
  Widget buildCategory() {
    return ScopedModel<CourseViewModel>(
        model: Get.find<CourseViewModel>(),
        child: ScopedModelDescendant<CourseViewModel>(
            builder: (context, child, model) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                courseStatus.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CourseStatusItem(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    data: courseStatus[index],
                    isSelected: index == selectedCategoryIndex,
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                        Get.find<CourseViewModel>().getCourses(
                            status: courseStatus[selectedCategoryIndex]
                                ["value"]);
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
