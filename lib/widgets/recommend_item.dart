import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';
import 'package:mentor_mentee_connecting/widgets/custom_image.dart';

class RecommendItem extends StatelessWidget {
  RecommendItem({Key? key, required this.data, this.onTap}) : super(key: key);
  CourseDTO data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.9,
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
            children: [
              CustomImage(
                data.imageUrl ?? "/assest/images/no-data.png",
                radius: 8,
                height: 88,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
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
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 32,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Text(
                            formatPrice(data.price ?? 0.0),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.mentor?.fullName ?? "Mentor",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class $ {}
