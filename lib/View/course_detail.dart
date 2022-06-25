import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';
import 'package:mentor_mentee_connecting/Utils/format_time.dart';
import 'package:mentor_mentee_connecting/View/courses.dart';
import 'package:mentor_mentee_connecting/ViewModel/session_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/custom_image.dart';
import 'package:scoped_model/scoped_model.dart';

class CourseDetails extends StatefulWidget {
  CourseDTO data;

  CourseDetails({
    Key? key,
    required this.data,
  }) : super(key: key);
  bool isExpanded = false;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  void initState() {
    super.initState();
    Get.find<SessionViewModel>().getSessionsByCourseId(widget.data.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: appBarColor,
          centerTitle: true,
          toolbarHeight: 76,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              MdiIcons.chevronLeft,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: Text(
            widget.data.name ?? "Details",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
        ),
        body: buildBody(),
        bottomNavigationBar: bottomBar());
  }

  buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Curriculum",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20, color: textColor, fontWeight: FontWeight.w600),
          ),
          buildListSession()
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      margin: EdgeInsets.all(16),
      height: 70,
      padding: EdgeInsets.all(12),
      child: FlatButton(
        onPressed: () async {
          // pr.hide();
          // showStateDialog();
        },
        height: 40,
        padding: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        textColor: Colors.white,
        color: primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Text("Chỉnh sửa khóa học",
            style: TextStyle(fontSize: 18, color: textBoxColor)),
      ),
    );
  }

  // getAttribute(IconData icon, Color color, String info) {
  //   return Row(
  //     children: [
  //       Icon(
  //         icon,
  //         size: 18,
  //         color: color,
  //       ),
  //       SizedBox(
  //         width: 4,
  //       ),
  //       Text(
  //         info,
  //         maxLines: 1,
  //         overflow: TextOverflow.ellipsis,
  //         style: TextStyle(color: labelColor, fontSize: 14),
  //       ),
  //     ],
  //   );
  // }

  buildListSession() {
    return ScopedModel<SessionViewModel>(
      model: Get.find<SessionViewModel>(),
      child: ScopedModelDescendant<SessionViewModel>(
          builder: (context, child, model) {
        List<SessionDTO>? list = model.listSession;
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
                      child: buildSession(list[index])),
                ))),
          );
      }),
    );
  }

  Widget buildSession(SessionDTO data,
      {String? subject,
      String? task,
      String? submissionDate,
      String? statusText,
      int status = 0}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? "session",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    "Kết thúc",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(formatDateType(
                      data.startTime ?? "1974-03-20 00:00:00.000")),
                  Text(formatTimeType(
                      data.startTime ?? "1974-03-20 00:00:00.000")),
                ],
              ))
        ],
      ),
    );
  }
}
