import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/Utils/data.dart';
import 'package:mentor_mentee_connecting/Utils/format_time.dart';
import 'package:mentor_mentee_connecting/ViewModel/session_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/activity_item.dart';
import 'package:mentor_mentee_connecting/Widgets/category_item.dart';
import 'package:mentor_mentee_connecting/Widgets/session_card.dart';
import 'package:mentor_mentee_connecting/widgets/custom_textfield.dart';
import 'package:scoped_model/scoped_model.dart';

class MyActivityPage extends StatefulWidget {
  const MyActivityPage({Key? key}) : super(key: key);

  @override
  _MyActivityPageState createState() => _MyActivityPageState();
}

int selectedCategoryIndex = 0;
DateTime now = DateTime.now();

class _MyActivityPageState extends State<MyActivityPage> {
  @override
  void initState() {
    // final today = DateTime(now.year, now.month, now.day);
    // final yesterday = DateTime(now.year, now.month, now.day - 1);
    // final tomorrow = DateTime(now.year, now.month, now.day + 1);
    Get.find<SessionViewModel>().getSessionsByDate(
        DateTime(now.year, now.month, now.day + selectedCategoryIndex));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(children: [
        getHeader(),
        buildCategory(),
        buildListSession(),
      ]),
    );
  }

  getHeader() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My Activity",
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

  // getChats() {
  //   return ListView(
  //       padding: EdgeInsets.only(top: 10),
  //       shrinkWrap: true,
  //       children: List.generate(
  //           chats.length,
  //           (index) => ActivityItem(
  //                 chats[index],
  //                 onTap: () {},
  //               )));
  // }
  buildListSession() {
    return ScopedModel<SessionViewModel>(
      model: Get.find<SessionViewModel>(),
      child: ScopedModelDescendant<SessionViewModel>(
          builder: (context, child, model) {
        List<SessionDTO>? list = model.listTodaySession;
        if (list == null)
          return SizedBox(
            height: 30,
          );
        else
          return Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(top: 12),
                child: Column(
                    children: List.generate(
                  list.length,
                  (index) => Container(
                      padding: EdgeInsets.only(bottom: 12),
                      child: SessionCard(data: list[index])),
                ))),
          );
      }),
    );
  }

  // Widget buildSession(SessionDTO data,
  //     {String? subject,
  //     String? task,
  //     String? submissionDate,
  //     String? statusText,
  //     int status = 0}) {
  //   return GestureDetector(
  //     onTap: () => Get.toNamed(RouteHandler.SESSION_DETAILS, arguments: data),
  //     child: Container(
  //       clipBehavior: Clip.antiAlias,
  //       padding: EdgeInsets.all(8),
  //       width: MediaQuery.of(context).size.width * 0.95,
  //       height: 80,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.1),
  //             spreadRadius: 1,
  //             blurRadius: 1,
  //             offset: Offset(1, 1), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Expanded(
  //             flex: 5,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   data.name ?? "Session",
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 2,
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(top: 2),
  //                   child: Text(
  //                     "Kết thúc",
  //                     style:
  //                         TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Expanded(
  //               flex: 2,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     formatDateType(
  //                         data.startTime ?? "1974-03-20 00:00:00.000"),
  //                     style:
  //                         TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //                   ),
  //                   Text(
  //                       formatTimeType(
  //                           data.startTime ?? "1974-03-20 00:00:00.000"),
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w600)),
  //                 ],
  //               ))
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildCategory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          dateCategories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              data: dateCategories[index],
              isSelected: index == selectedCategoryIndex,
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                  Get.find<SessionViewModel>().getSessionsByDate(DateTime(
                      now.year, now.month, now.day + selectedCategoryIndex));
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
