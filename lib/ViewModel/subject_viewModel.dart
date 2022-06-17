import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/SubjectDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SubjectDTO.dart';
import 'package:mentor_mentee_connecting/ViewModel/base_model.dart';

class SubjectViewModel extends BaseModel {
  SubjectDAO? dao;
  List<SubjectDTO>? listSubject;
  SubjectViewModel() {
    dao = SubjectDAO();
  }

  Future<void> getAllSubjects() async {
    try {
      setState(ViewStatus.Loading);
      listSubject = await dao?.getAllSubjects();
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listSubject = null;
      setState(ViewStatus.Completed);
    }
  }
}
