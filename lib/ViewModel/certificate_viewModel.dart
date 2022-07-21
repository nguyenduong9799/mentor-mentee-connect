import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:mentor_mentee_connecting/Model/DAO/CertificateDAO.dart';
import 'package:mentor_mentee_connecting/Model/DAO/MajorDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CertificateDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MajorDTO.dart';

import 'base_model.dart';

class CertificateViewModel extends BaseModel {
  CertificateDAO? dao;
  List<CertificateDTO>? listCertificate;
  CertificateViewModel() {
    dao = CertificateDAO();
  }

  Future<void> getAllCertificates() async {
    try {
      setState(ViewStatus.Loading);
      listCertificate = await dao?.getAllCertificates();
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      listCertificate = null;
      setState(ViewStatus.Completed);
    }
  }
}
