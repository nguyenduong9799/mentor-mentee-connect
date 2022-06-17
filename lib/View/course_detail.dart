import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';
import 'package:mentor_mentee_connecting/View/courses.dart';
import 'package:mentor_mentee_connecting/Widgets/custom_image.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: appBarColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              MdiIcons.chevronLeft,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Detail",
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
          CustomImage(
            widget.data.imageUrl ?? "assets/images/no-data.png",
            radius: 15,
            width: MediaQuery.of(context).size.width,
            height: 200,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            widget.data.name ?? "Course",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20, color: textColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getAttribute(Icons.play_circle_outlined, labelColor, "12"),
              SizedBox(
                width: 16,
              ),
              getAttribute(Icons.schedule_rounded, labelColor, "12"),
              SizedBox(
                width: 16,
              ),
              getAttribute(
                  Icons.star, yellow, widget.data.totalRating.toString()),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Description",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16, color: textColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 12,
          ),
          ConstrainedBox(
              constraints: widget.isExpanded
                  ? new BoxConstraints()
                  : new BoxConstraints(maxHeight: 36),
              child: new Text(
                widget.data.description ?? "des",
                softWrap: true,
                overflow: TextOverflow.fade,
              )),
          widget.isExpanded
              ? InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        "show less",
                        style: new TextStyle(color: primary),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() => widget.isExpanded = false);
                  },
                )
              : new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        "show more",
                        style: new TextStyle(color: primary),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() => widget.isExpanded = true);
                  },
                )
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    formatPrice(widget.data.price ?? 0.0),
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: FlatButton(
              onPressed: () async {
                // pr.hide();
                // showStateDialog();
              },
              height: 50,
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              textColor: Colors.white,
              color: primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text("Buy now",
                  style: TextStyle(fontSize: 18, color: textBoxColor)),
            ),
          ),
        ],
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

  Widget buildSession(
      {String? subject,
      String? task,
      String? submissionDate,
      String? statusText,
      int status = 0}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.fromLTRB(24, 8, 24, 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: appBgColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [],
          border: Border.all(color: appBgColor, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(6),
            decoration:
                BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            // child: Icon(
            //   iconData,
            //   color: iconColor,
            //   size: MySize.size20,
            // ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subject!,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                      task!,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                submissionDate!,
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  statusText!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
