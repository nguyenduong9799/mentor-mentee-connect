import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/data.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/my_course.dart';
import 'package:mentor_mentee_connecting/Widgets/recommend_item.dart';
import 'package:mentor_mentee_connecting/widgets/category_item.dart';
import 'package:mentor_mentee_connecting/widgets/custom_textfield.dart';
import 'package:scoped_model/scoped_model.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.animation!.addListener(() {
      final aniValue = _tabController!.animation!.value;
      if (aniValue - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (aniValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
    super.initState();
  }

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
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                      child: Text("Waiting",
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  _currentIndex == 0 ? primary : textColor))),
                  Tab(
                      child: Text("In Progress",
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  _currentIndex == 1 ? primary : textColor))),
                  Tab(
                      child: Text("Done",
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  _currentIndex == 2 ? primary : textColor))),
                ],
                labelColor: primary,
                indicatorColor: primary,
                unselectedLabelColor: appBgColor,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => getTabContent(),
                childCount: 1,
              ),
            )
          ],
        ));
    // Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    //   getHeader(),
    //   TabBar(
    //     controller: _tabController,
    //     tabs: [
    //       Tab(child: Text("Tab 1", style: TextStyle(color: textColor))),
    //       Tab(child: Text("Tab 2", style: TextStyle(color: textColor))),
    //     ],
    //   ),
    //   TabBarView(
    //     controller: _tabController,
    //     children: <Widget>[getTabContent()],
    //   )
    // ]);
  }

  Widget getAppBar() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 48, 0, 4),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "My Course",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  getTabContent() {
    return ScopedModel<CourseViewModel>(
        model: Get.find<CourseViewModel>(),
        child: ScopedModelDescendant<CourseViewModel>(
            builder: (context, child, model) {
          List<CourseDTO>? courses = model.listCourse;
          if (courses == null)
            return SizedBox(
              height: 30,
            );
          else
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(top: 12),
                child: Column(
                    children: List.generate(
                        courses.length,
                        (index) => Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: MyCourseItem(
                              data: courses[index],
                              onTap: () {},
                            )))));
        }));
  }
}
