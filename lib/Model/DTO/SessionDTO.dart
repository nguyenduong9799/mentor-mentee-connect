class SessionDTO {
  int? id;
  String? name;
  String? description;
  String? startTime;
  String? endTime;
  int? status;
  int? courseId;

  SessionDTO(
      {this.id,
      this.name,
      this.description,
      this.startTime,
      this.endTime,
      this.status,
      this.courseId});

  SessionDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    courseId = json['courseId'];
  }

  static List<SessionDTO> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => SessionDTO.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['courseId'] = this.courseId;
    return data;
  }
}
