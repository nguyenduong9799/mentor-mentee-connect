import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MenteeSessionDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/ViewModel/menteeSession_viewModel.dart';
import 'chat_notify.dart';
import 'custom_image.dart';

class MenteeCard extends StatelessWidget {
  final MenteeSessionDTO data;
  const MenteeCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImage(
              data.mentee?.imageUrl ?? "no-data.png",
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                flex: 2,
                child: Container(
                    child: Text(data.mentee?.fullName ?? "Mentee",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () async {
                  if (data.isAttended == 0)
                    await showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Xác nhận mentee có mặt'),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await Get.find<MenteeSessionViewModel>()
                                    .checkAttendantMentee(data.id ?? 0);
                                await Get.find<MenteeSessionViewModel>()
                                    .getAllMenteeBySession(data.sessionId ?? 0);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Xác nhận'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Hủy'),
                            ),
                          ],
                          // content: Container(
                          //     padding: const EdgeInsets.all(20),
                          //     child: Text("Xác nhận mentee có mặt")),
                        );
                      },
                    );
                },
                height: 50,
                padding: EdgeInsets.only(
                  left: 4,
                  right: 4,
                ),
                textColor: Colors.white,
                color: data.isAttended == 0 ? primary : labelColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                    (data.isAttended == 0 || data.isAttended == null)
                        ? "Điểm danh"
                        : "Đã điểm danh",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: textBoxColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
