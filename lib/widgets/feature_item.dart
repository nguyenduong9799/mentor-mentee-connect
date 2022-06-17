import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';

import 'custom_image.dart';

class FeatureItem extends StatelessWidget {
  FeatureItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 240,
      this.onTap})
      : super(key: key);
  CourseDTO data;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        // padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            CustomImage(
              data.imageUrl ?? "/assest/images/no-data.png",
              width: double.infinity,
              height: 140,
              radius: 1,
            ),
            // Positioned(
            //   top: 120,
            //   right: 15,
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: primary,
            //       borderRadius: BorderRadius.circular(20),
            //       boxShadow: [
            //         BoxShadow(
            //           color: shadowColor.withOpacity(0.05),
            //           spreadRadius: 1,
            //           blurRadius: 1,
            //           offset: Offset(0, 0),
            //         ),
            //       ],
            //     ),
            //     child: Text(
            //       formatPrice(data.price ?? 0.0),
            //       style: TextStyle(
            //           color: Colors.white, fontWeight: FontWeight.w500),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 144,
              child: Container(
                width: width,
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 44,
                      child: Text(
                        data.name ?? "Course",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data.subject?.name ?? "Subject",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              color: primary,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          formatPrice(data.price ?? 0.0),
                          style: TextStyle(
                              color: third,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getAttribute(Icons.play_circle_outlined, labelColor,
                            data.slug ?? "Test"),
                        SizedBox(
                          width: 8,
                        ),
                        getAttribute(
                          Icons.star,
                          yellow,
                          data.totalRating.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: labelColor, fontSize: 16),
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          icon,
          size: 20,
          color: color,
        ),
      ],
    );
  }
}
