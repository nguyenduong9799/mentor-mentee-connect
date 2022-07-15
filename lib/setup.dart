import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/course_ViewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/major_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/root_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/session_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/subject_viewModel.dart';

import 'Service/push_notification_service.dart';
import 'ViewModel/login_viewModel.dart';
import 'firebase_options.dart';

Future setUp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // PushNotificationService? ps = PushNotificationService.getInstance();
  // await ps!.init();
}

void createRouteBindings() async {
  Get.put(RootViewModel());
  Get.put(LoginViewModel());
  Get.put(CourseViewModel());
  Get.put(AccountViewModel());
  Get.put(SubjectViewModel());
  Get.put(SessionViewModel());
  Get.put(MajorViewModel());
}
