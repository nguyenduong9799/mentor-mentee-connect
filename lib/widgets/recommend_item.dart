import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/widgets/custom_image.dart';

class RecommendItem extends StatelessWidget {
  RecommendItem({Key? key, required this.data, this.onTap}) : super(key: key);
  CourseDTO data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHandler.COURSE_DETAILS, arguments: data);
      },
      child: Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.95,
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
            children: [
              CustomImage(
                data.imageUrl ?? "no-data.png",
                radius: 8,
                height: 80,
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        data.name ?? "Course",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          color: labelColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Session",
                          style: TextStyle(fontSize: 12, color: labelColor),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.star,
                          color: orange,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          data.totalRating.toString(),
                          style: TextStyle(fontSize: 12, color: labelColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () async {
                    bool result = await Get.toNamed(RouteHandler.UPDATE_COURSE,
                        arguments: data);
                    if (result != null) {
                      if (result) {
                        await Get.find<CourseViewModel>().getCourses();
                      }
                    }
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                  ))
            ],
          )),
    );
  }
}

class $ {}
