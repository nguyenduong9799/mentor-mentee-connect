import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Utils/constant.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/Widgets/form_item.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scoped_model/scoped_model.dart';

class Update extends StatefulWidget {
  const Update({Key? key, required this.user}) : super(key: key);
  final AccountDTO user;

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final form = FormGroup({
    'name': FormControl(validators: [
      Validators.required,
      Validators.minLength(5),
      Validators.maxLength(255),
    ], touched: false),
    'phone': FormControl(validators: [
      Validators.required,
      Validators.pattern(phoneReg),
      // Validators.number,
    ], touched: false),
    'email': FormControl(validators: [
      Validators.email,
    ], touched: false),
    'bio': FormControl(validators: [], touched: false),
    'birthdate': FormControl<DateTime>(validators: [], touched: false),
    'gender': FormControl(validators: [
      Validators.required,
    ], touched: false, value: 0),
  });

  @override
  void initState() {
    super.initState();

    final user = widget.user;
    // UPDATE USER INFO INTO FORM
    if (user != null) {
      form.value = {
        "name": user.fullName,
        "phone": user.phone,
        "email": user.email,
        "birthdate": DateTime.parse(user.dayOfBirth!.replaceAll('T', ' ')),
        "gender": user.gender,
        "bio": user.bio
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
                              FormItem("Họ Tên", "vd: Nguyễn Văn A", "name"),
                              FormItem(
                                "Email",
                                "vd: abc@gmail.com",
                                "email",
                                isReadOnly: true,
                              ),
                              FormItem(
                                "Số Điện Thoại",
                                "012345678",
                                "phone",
                              ),
                              FormItem(
                                "Ngày sinh",
                                "01/01/2000",
                                "birthdate",
                                keyboardType: "datetime",
                                fromYear: DateTime(1950),
                                toYear: DateTime(2010),
                              ),
                              FormItem(
                                "Giới tính",
                                null,
                                "gender",
                                keyboardType: "radio",
                                radioGroup: [
                                  {
                                    "title": "Nam",
                                    "value": 1,
                                  },
                                  {
                                    "title": "Nữ",
                                    "value": 2,
                                  },
                                  {
                                    "title": "Khác",
                                    "value": 3,
                                  }
                                ],
                              ),
                              FormItem(
                                "Giới thiệu",
                                "Bio",
                                "bio",
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
                                        await model.updateUser(form.value);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: model.status == ViewStatus.Loading
                                          ? CircularProgressIndicator(
                                              backgroundColor: primary)
                                          : Text(
                                              form.valid
                                                  ? "Hoàn thành"
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
            elevation: 3,
            backgroundColor: appBarColor,
            centerTitle: true,
            toolbarHeight: 76,
            // leading: IconButton(
            //   onPressed: () => Get.back(),
            //   icon: Icon(
            //     MdiIcons.chevronLeft,
            //     color: Colors.black,
            //     size: 30,
            //   ),
            // ),
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
