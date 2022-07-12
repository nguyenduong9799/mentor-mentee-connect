import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/base_model.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/session_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/subject_viewModel.dart';

class RootViewModel extends BaseModel {
  AccountDTO? user;
  Future startUp() async {
    await Get.find<AccountViewModel>().fetchUser();
    await Get.find<CourseViewModel>().getCourses();
    await Get.find<SubjectViewModel>().getAllSubjects();
    await Get.find<SessionViewModel>().getSessionsByDate(DateTime.now());
  }
}
