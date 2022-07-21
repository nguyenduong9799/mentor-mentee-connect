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
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImage(
                data.imageUrl ?? "no-data.png",
                radius: 8,
                height: 60,
                width: 60,
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
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
                    color: secondary,
                  ))
            ],
          )),
    );
  }
}

class $ {}
