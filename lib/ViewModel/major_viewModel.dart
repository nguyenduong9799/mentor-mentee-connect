import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/MajorDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MajorDTO.dart';

import 'base_model.dart';

class MajorViewModel extends BaseModel {
  MajorDAO? dao;
  List<MajorDTO>? listMajor;
  MajorViewModel() {
    dao = MajorDAO();
  }

  Future<void> getAllMajors() async {
    try {
      setState(ViewStatus.Loading);
      listMajor = await dao?.getAllMajors();
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listMajor = null;
      setState(ViewStatus.Completed);
    }
  }
}
