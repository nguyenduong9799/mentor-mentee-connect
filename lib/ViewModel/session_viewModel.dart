import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/SessionDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/ViewModel/base_model.dart';

class SessionViewModel extends BaseModel {
  SessionDAO? dao;
  List<SessionDTO>? listSession;
  SessionViewModel() {
    dao = SessionDAO();
  }

  Future<void> getSessionsByCourseId(int courseId) async {
    try {
      setState(ViewStatus.Loading);
      listSession = await dao?.getSessionsByCourseId(courseId);
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listSession = null;
      setState(ViewStatus.Completed);
    }
  }
}
