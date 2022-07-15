import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/CourseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/ViewModel/base_model.dart';

class CourseViewModel extends BaseModel {
  CourseDAO? courseDAO;
  List<CourseDTO>? listCourse;
  CourseViewModel() {
    courseDAO = CourseDAO();
  }

  Future<void> getCourses({majorId}) async {
    try {
      setState(ViewStatus.Loading);
      listCourse = await courseDAO?.getAllCourses(params: {'id': majorId});
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listCourse = null;
      setState(ViewStatus.Completed);
    }
  }
}
