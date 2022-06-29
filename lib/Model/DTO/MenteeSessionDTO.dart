import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';

class MenteeSessionDTO {
  int? id;
  int? menteeId;
  AccountDTO? mentee;
  int? sessionId;
  int? isAttended;
  int? reportId;
  int? rating;

  MenteeSessionDTO(
      {this.id,
      this.menteeId,
      this.mentee,
      this.sessionId,
      this.isAttended,
      this.reportId,
      this.rating});

  MenteeSessionDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menteeId = json['menteeId'];
    mentee =
        json['mentee'] != null ? new AccountDTO.fromJson(json['mentee']) : null;
    sessionId = json['sessionId'];
    isAttended = json['isAttended'];
    reportId = json['reportId'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menteeId'] = this.menteeId;
    if (this.mentee != null) {
      data['mentee'] = this.mentee!.toJson();
    }
    data['sessionId'] = this.sessionId;
    data['isAttended'] = this.isAttended;
    data['reportId'] = this.reportId;
    data['rating'] = this.rating;
    return data;
  }

  static List<MenteeSessionDTO> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => MenteeSessionDTO.fromJson(map)).toList();
  }
}
