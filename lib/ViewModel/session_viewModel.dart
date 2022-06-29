import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/MenteeSessionDAO.dart';
import 'package:mentor_mentee_connecting/Model/DAO/SessionDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MenteeSessionDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/ViewModel/base_model.dart';

class SessionViewModel extends BaseModel {
  SessionDAO? dao;
  MenteeSessionDAO? menteeSessionDao;
  List<SessionDTO>? listSession;
  List<MenteeSessionDTO>? listMenteeSession;
  SessionViewModel() {
    menteeSessionDao = MenteeSessionDAO();
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

  Future<void> getAllMenteeSessionById(int sessionId) async {
    try {
      setState(ViewStatus.Loading);
      listMenteeSession =
          await menteeSessionDao?.getAllMenteeSessionById(sessionId);
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listMenteeSession = null;
      setState(ViewStatus.Completed);
    }
  }
}
