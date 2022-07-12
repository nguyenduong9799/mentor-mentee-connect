import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/constant.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/form_item.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateCourse extends StatefulWidget {
  const UpdateCourse({Key? key, required this.course}) : super(key: key);
  final CourseDTO course;

  @override
  _UpdateCourseState createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {
  final form = FormGroup({
    'name': FormControl(validators: [
      Validators.required,
      Validators.minLength(2),
    ], touched: false),
    'description': FormControl(validators: [
      Validators.required,
      Validators.minLength(2),
    ], touched: false),
    'minQuantity': FormControl(validators: [
      Validators.number,
      Validators.required,
    ], touched: false),
    'maxQuantity': FormControl(validators: [
      Validators.number,
      Validators.required,
    ], touched: false),
    'location': FormControl(validators: [
      Validators.required,
      Validators.minLength(2),
    ], touched: false),
    'startDate': FormControl<DateTime>(
        validators: [Validators.required], touched: false),
    'finishDate': FormControl<DateTime>(
        validators: [Validators.required], touched: false),
    'startDate': FormControl<DateTime>(
        validators: [Validators.required], touched: false),
  });

  @override
  void initState() {
    super.initState();

    final course = widget.course;
    // UPDATE USER INFO INTO FORM
    if (course != null) {
      form.value = {
        "name": course.name,
        "minQuantity": course.minQuantity.toString(),
        "maxQuantity": course.maxQuantity.toString(),
        "description": course.description,
        "startDate": course.startDate,
        "finishDate": course.finishDate,
        "location": course.location,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: AccountViewModel(),
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ReactiveForm(
            formGroup: this.form,
            child: Container(
              color: Color(0xFFddf1ed),
              child: Column(
                children: [
                  // SIGN-UP FORM
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(16),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: Column(
                        children: [
                          // HELLO SECTIO
                          Expanded(
                              child: ListView(
                            children: [
                              FormItem(
                                  "Tên khóa học", "vd: Nguyễn Văn A", "name"),
                              FormItem(
                                "Chi tiết khóa học",
                                "vd: abc@gmail.com",
                                "description",
                              ),
                              FormItem(
                                "Số lượng học viên tối thiểu",
                                "012345678",
                                "minQuantity",
                                keyboardType: "number",
                              ),
                              FormItem(
                                "Số lượng học viên tối đa",
                                "012345678",
                                "maxQuantity",
                                keyboardType: "number",
                              ),
                              FormItem(
                                "Nơi học",
                                "vd: abc@gmail.com",
                                "location",
                              ),
                              FormItem(
                                "Ngày bắt đầu",
                                "01/01/2000",
                                "startDate",
                                keyboardType: "datetime",
                                fromYear: DateTime(1950),
                              ),
                              FormItem(
                                "Ngày kết túc",
                                "01/01/2000",
                                "finishDate",
                                keyboardType: "datetime",
                                fromYear: DateTime(1950),
                              ),
                            ],
                          )),
                          ReactiveFormConsumer(builder: (context, form, child) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 2000),
                              curve: Curves.easeInOut,
                              margin: EdgeInsets.only(bottom: 8),
                              child: Center(
                                child: ScopedModelDescendant<AccountViewModel>(
                                  builder: (context, child, model) =>
                                      RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      // side: BorderSide(color: Colors.red),
                                    ),
                                    color: form.valid ? primary : Colors.grey,
                                    onPressed: () async {
                                      if (model.status ==
                                          ViewStatus
                                              .Completed) if (form.valid) {
                                        // await model.updateUser(form.value);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: model.status == ViewStatus.Loading
                                          ? CircularProgressIndicator(
                                              backgroundColor: primary)
                                          : Text(
                                              form.valid
                                                  ? "Cập nhật"
                                                  : "Bạn chưa điền xong",
                                              style: Get
                                                  .theme.textTheme.headline6!
                                                  .copyWith(
                                                      color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          // FORM ITEM
                          //SIGN UP BUTTON
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            elevation: 2,
            backgroundColor: appBarColor,
            centerTitle: true,
            toolbarHeight: 60,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                MdiIcons.chevronLeft,
                color: Colors.black,
                size: 30,
              ),
            ),
            title: Text(
              "Cập nhật thông tin",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
