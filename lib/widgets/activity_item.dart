import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';

import 'chat_notify.dart';
import 'custom_image.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem(this.chatData,
      {Key? key, this.onTap, this.isNotified = true, this.profileSize = 80})
      : super(key: key);
  final chatData;
  final bool isNotified;
  final GestureTapCallback? onTap;
  final double profileSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                child: Text(
                                    "PRO221-Kiểu,biến và hằng số trong java",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)))),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("Today, From 9:30 Am To 11:00 Am",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(fontSize: 16, color: primary))),
                        // if (isNotified)
                        //   Padding(
                        //       padding: const EdgeInsets.only(right: 5),
                        //       child: Container(
                        //           child: Text("1.5 hour",
                        //               maxLines: 1,
                        //               overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(
                        //                 fontSize: 16,
                        //               ))))
                      ],
                    ),
                  ],
                ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
