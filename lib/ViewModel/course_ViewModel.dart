import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/CourseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/ViewModel/account_viewModel.dart';
import 'package:mentor_mentee_connecting/ViewModel/base_model.dart';

class CourseViewModel extends BaseModel {
  CourseDAO? courseDAO;
  List<CourseDTO>? listCourse;
  CourseViewModel() {
    courseDAO = CourseDAO();
  }

  Future<void> getCourses({int status = 3}) async {
    try {
      setState(ViewStatus.Loading);
      AccountDTO user = Get.find<AccountViewModel>().currentUser;
      listCourse = await courseDAO
          ?.getAllCourses(params: {"mentor-id": user.id, "status": status});
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listCourse = null;
      setState(ViewStatus.Completed);
    }
  }

  Future<void> updateCourse(
      CourseDTO courseDTO, Map<String, dynamic> course) async {
    try {
      setState(ViewStatus.Loading);

      // final courseDTO = CourseDTO(
      //     id: courseId,
      //     name: course["name"],
      //     description: course["description"],
      //     location: course["location"]);

      courseDTO.name = course["name"];
      courseDTO.description = course["description"];
      courseDTO.location = course["location"];
      await courseDAO?.updateCourse(courseDTO);
      // setToken here
      setState(ViewStatus.Completed);
      Get.back(result: true);
      // await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      printError();
      print(e);
      setState(ViewStatus.Error);
    }
  }
}
