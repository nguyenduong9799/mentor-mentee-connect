import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/MenteeSessionDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MenteeSessionDTO.dart';

import 'base_model.dart';

class MenteeSessionViewModel extends BaseModel {
  MenteeSessionDAO? dao;
  List<MenteeSessionDTO>? listMenteeSession;
  MenteeSessionViewModel() {
    dao = MenteeSessionDAO();
  }

  Future<void> getAllMenteeBySession(int id) async {
    try {
      setState(ViewStatus.Loading);
      listMenteeSession = await dao?.getAllMenteeSessionById(id);
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listMenteeSession = null;
      setState(ViewStatus.Completed);
    }
  }

  Future<void> checkAttendantMentee(int id) async {
    try {
      setState(ViewStatus.Loading);
      await dao?.checkAttendant(id);
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      printError();
      print(e);
      setState(ViewStatus.Completed);
    }
  }
}
