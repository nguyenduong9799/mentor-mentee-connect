import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CertificateDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MenteeSessionDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/data.dart';
import 'package:mentor_mentee_connecting/Utils/format_price.dart';
import 'package:mentor_mentee_connecting/View/courses.dart';
import 'package:mentor_mentee_connecting/ViewModel/certificate_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/menteeSession_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/certificate_card.dart';
import 'package:mentor_mentee_connecting/Widgets/custom_image.dart';
import 'package:mentor_mentee_connecting/Widgets/mentee_card.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCertificatePage extends StatefulWidget {
  MyCertificatePage({
    Key? key,
  }) : super(key: key);
  bool isExpanded = false;

  @override
  State<MyCertificatePage> createState() => _MyCertificatePageState();
}

class _MyCertificatePageState extends State<MyCertificatePage> {
  @override
  void initState() {
    super.initState();
    Get.find<CertificateViewModel>().getAllCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            MdiIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Danh sách chứng chỉ",
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
      body: buildBody(),
      // bottomNavigationBar: bottomBar()
    );
  }

  buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [getCertificates()],
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      height: 80,
      padding: EdgeInsets.all(16),
      child: FlatButton(
        onPressed: () async {
          // pr.hide();
          // showStateDialog();
        },
        height: 50,
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        textColor: Colors.white,
        color: primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text("Chỉnh sửa",
            style: TextStyle(fontSize: 18, color: textBoxColor)),
      ),
    );
  }

  getCertificates() {
    return ScopedModel<CertificateViewModel>(
      model: Get.find<CertificateViewModel>(),
      child: ScopedModelDescendant<CertificateViewModel>(
          builder: (context, child, model) {
        List<CertificateDTO>? list = model.listCertificate;
        if (list == null || list.length == 0)
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              height: 30,
              child: Text("Hiện tai chưa có chứng chỉ nào",
                  style: TextStyle(fontSize: 20, color: primary)),
            ),
          );
        else
          return Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 16),
              child: Column(
                  children: List.generate(list.length,
                      (index) => CertificateCard(data: list[index]))),
            ),
          );
      }),
    );
  }
}
