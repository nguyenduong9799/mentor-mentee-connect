import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/theme/color.dart';
import 'package:mentor_mentee_connecting/widgets/custom_image.dart';

class RecommendItem extends StatelessWidget {
  RecommendItem({Key? key, required this.data, this.onTap}) : super(key: key);
  final data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          padding: EdgeInsets.all(12),
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
                data["image"],
                radius: 8,
                height: 88,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
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
                        data["session"],
                        style: TextStyle(fontSize: 12, color: labelColor),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: orange,
                        size: 16,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        data["review"],
                        style: TextStyle(fontSize: 12, color: labelColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Nguyen Duong",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        data["price"],
                        style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
