import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';

import 'SubjectDTO.dart';

class CertificateDTO {
  int? id;
  String? imageUrl;
  int? status;
  String? name;
  int? subjectId;
  int? mentorId;
  String? sort;
  SubjectDTO? subject;
  AccountDTO? mentor;

  CertificateDTO(
      {this.id,
      this.imageUrl,
      this.status,
      this.name,
      this.subjectId,
      this.mentorId,
      this.sort,
      this.subject,
      this.mentor});

  CertificateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    name = json['name'];
    subjectId = json['subjectId'];
    mentorId = json['mentorId'];
    sort = json['sort'];
    subject = json['subject'] != null
        ? new SubjectDTO.fromJson(json['subject'])
        : null;
    mentor =
        json['mentor'] != null ? new AccountDTO.fromJson(json['mentor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['name'] = this.name;
    data['subjectId'] = this.subjectId;
    data['mentorId'] = this.mentorId;
    data['sort'] = this.sort;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.mentor != null) {
      data['mentor'] = this.mentor!.toJson();
    }
    return data;
  }

  static List<CertificateDTO> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => CertificateDTO.fromJson(map)).toList();
  }
}
