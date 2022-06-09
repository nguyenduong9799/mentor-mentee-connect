import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';

import 'custom_image.dart';

class FeatureItem extends StatelessWidget {
  FeatureItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 240,
      this.onTap})
      : super(key: key);
  final data;
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
              data["image"],
              width: double.infinity,
              height: 140,
              radius: 1,
            ),
            Positioned(
              top: 120,
              right: 15,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
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
                  data["price"],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                width: width - 20,
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Coding",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color: secondary,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        getAttribute(Icons.star, yellow, data["review"]),
                      ],
                    ),
                    Text(
                      data["name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data["description"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: labelColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImage(
                          data["image"],
                          width: 20,
                          height: 20,
                          radius: 60,
                        ),
                        Flexible(
                          child: Text(
                            "Nguyen Duong",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: textColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          child: getAttribute(Icons.play_circle_outlined,
                              labelColor, data["session"]),
                        )
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
          style: TextStyle(color: labelColor, fontSize: 12),
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          icon,
          size: 16,
          color: color,
        ),
      ],
    );
  }
}
