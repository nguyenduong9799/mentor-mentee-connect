import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormItem extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? formName;
  final String? keyboardType;
  final bool? isReadOnly;
  final DateTime? fromYear;
  final DateTime? toYear;

  final List<Map<String, dynamic>>? radioGroup;

  FormItem(this.label, this.hintText, this.formName,
      {Key? key,
      this.keyboardType,
      this.radioGroup,
      this.isReadOnly = false,
      this.fromYear,
      this.toYear})
      : super(key: key);

  Widget _getFormItemType(FormGroup form) {
    final formControl = form.control(formName ?? "");

    switch (keyboardType) {
      case "radio":
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...radioGroup!
                .map((e) => Flexible(
                      child: Row(
                        children: [
                          ReactiveRadio(
                            value: e["value"],
                            formControlName: formName,
                          ),
                          Text(
                            e["title"],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        );
      case "datetime":
        return ReactiveDatePicker(
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          formControlName: formName,
          builder: (BuildContext context, ReactiveDatePickerDelegate picker,
              Widget? child) {
            return GestureDetector(
              onTap: () {
                picker.showPicker();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 72,
                child: Theme(
                  data: ThemeData.dark(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          formControl.value != null
                              ? DateFormat('dd/MM/yyyy')
                                  .format((formControl.value as DateTime))
                              : "Chọn ngày",
                          style: Get.theme.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      case "number":
        return ReactiveTextField(
          validationMessages: (control) => {
            ValidationMessage.email: ':(',
            ValidationMessage.required: ':(',
            ValidationMessage.number: ':(',
            ValidationMessage.pattern: ':(',
            ValidationMessage.minLength: 'Tối thiểu 5 ký tự',
            ValidationMessage.maxLength: 'Tối đa 255 ký tự',
          },
          // enableInteractiveSelection: false,
          keyboardType: TextInputType.number,
          style: isReadOnly!
              ? TextStyle(color: primary)
              : Get.theme.textTheme.bodyText1,
          readOnly: isReadOnly!,
          formControlName: formName,
          textCapitalization: TextCapitalization.words,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: this.label == "Email"
              ? TextInputAction.done
              : TextInputAction.next,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFf4f4f6),
            suffixIcon: AnimatedOpacity(
                duration: Duration(milliseconds: 700),
                opacity: formControl.valid ? 1 : 0,
                curve: Curves.fastOutSlowIn,
                child: Icon(Icons.check, color: Color(0xff00d286))),
            focusColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                  color: isReadOnly! ? Colors.transparent : primary),
              // borderRadius: new BorderRadius.circular(25.7),
            ),
            enabledBorder: InputBorder.none,
            // border: OutlineInputBorder(
            //   borderSide: BorderSide.none,
            // ),
            // focusColor: Colors.red,
            hintText: hintText,
            // labelText: label,
          ),
        );
      default:
        return ReactiveTextField(
          validationMessages: (control) => {
            ValidationMessage.email: ':(',
            ValidationMessage.required: ':(',
            ValidationMessage.number: ':(',
            ValidationMessage.pattern: ':(',
            ValidationMessage.minLength: 'Tối thiểu 5 ký tự',
            ValidationMessage.maxLength: 'Tối đa 255 ký tự',
          },
          // enableInteractiveSelection: false,
          style: isReadOnly!
              ? TextStyle(color: primary)
              : Get.theme.textTheme.bodyText1,
          readOnly: isReadOnly!,
          formControlName: formName,
          textCapitalization: TextCapitalization.words,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: this.label == "Email"
              ? TextInputAction.done
              : TextInputAction.next,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFf4f4f6),
            suffixIcon: AnimatedOpacity(
                duration: Duration(milliseconds: 700),
                opacity: formControl.valid ? 1 : 0,
                curve: Curves.fastOutSlowIn,
                child: Icon(Icons.check, color: Color(0xff00d286))),
            focusColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                  color: isReadOnly! ? Colors.transparent : primary),
              // borderRadius: new BorderRadius.circular(25.7),
            ),
            enabledBorder: InputBorder.none,
            // border: OutlineInputBorder(
            //   borderSide: BorderSide.none,
            // ),
            // focusColor: Colors.red,
            hintText: hintText,
            // labelText: label,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        height: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Text(label!,
                  style: Get.theme.textTheme.bodyText1!
                      .copyWith(color: labelColor)),
            ),
            Flexible(
              flex: 5,
              child: Container(
                color: Color(0xFFf4f4f6),
                child: _getFormItemType(form),
              ),
            ),
          ],
        ),
      );
    });
  }
}
