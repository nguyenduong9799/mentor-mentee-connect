import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mentee_connecting/theme/color.dart';

class SettingBox extends StatelessWidget {
  SettingBox(
      {Key? key, required this.title, required this.icon, this.color = darker})
      : super(key: key);
  final title;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            color: color,
            width: 22,
            height: 22,
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            title,
            style: TextStyle(
                color: color, fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
