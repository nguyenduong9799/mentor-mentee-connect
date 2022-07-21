import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CertificateDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/constant.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';
import 'package:mentor_mentee_connecting/Utils/format_time.dart';
import 'package:mentor_mentee_connecting/View/courses.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/session_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/custom_image.dart';
import 'package:mentor_mentee_connecting/Widgets/session_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CertificateDetailsPage extends StatefulWidget {
  CertificateDTO data;

  CertificateDetailsPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  bool isExpanded = false;

  @override
  State<CertificateDetailsPage> createState() => _CertificateDetailsPageState();
}

class _CertificateDetailsPageState extends State<CertificateDetailsPage> {
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
          widget.data.name ?? "Chi tiết chứng chỉ",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Trạng thái:",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                widget.data.status == CertificateStatus.Approved
                    ? "Đã được duyệt"
                    : widget.data.status == CertificateStatus.Denied
                        ? "Bị từ chối"
                        : "Đang đợi duyệt",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          CustomImage(widget.data.imageUrl ?? "no-data.png",
              radius: 12,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              fit: BoxFit.fitWidth,
              isShadow: false),

          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 12,
          ),
          // buildListSession()
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      margin: EdgeInsets.all(8),
      height: 72,
      padding: EdgeInsets.all(12),
      child: FlatButton(
        onPressed: () async {
          dynamic result = await Get.toNamed(RouteHandler.UPDATE_COURSE,
              arguments: widget.data);
          if (result != null) {
            if (result) {
              await Get.find<CourseViewModel>().getCourses();
            }
          }
        },
        padding: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        textColor: Colors.white,
        color: primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text("Chỉnh sửa khóa học",
            style: TextStyle(fontSize: 18, color: textBoxColor)),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: labelColor, fontSize: 14),
        ),
      ],
    );
  }

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
                      child: SessionCard(data: list[index])),
                ))),
          );
      }),
    );
  }

  Widget buildSession(SessionDTO data) {
    return GestureDetector(
      onTap: () => Get.toNamed(RouteHandler.SESSION_DETAILS, arguments: data),
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.95,
        // height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.name ?? "Session",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      "Kết thúc",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatDateType(
                          data.startTime ?? "1974-03-20 00:00:00.000"),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        formatTimeType(
                            data.startTime ?? "1974-03-20 00:00:00.000"),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
