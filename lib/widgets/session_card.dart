import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/Utils/format_time.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({Key? key, required this.data}) : super(key: key);
  final SessionDTO data;

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                data.name ?? "Session",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    "Từ " +
                        formatTimeType(
                            data.startTime ?? "1974-03-20 00:00:00.000") +
                        " đến " +
                        formatTimeType(
                            data.endTime ?? "1974-03-20 00:00:00.000"),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(
                  width: 8,
                ),
                Text(
                  formatDateType(data.startTime ?? "1974-03-20 00:00:00.000"),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
