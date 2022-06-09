class CertificateDTO {
  int? id;
  String? imageUrl;
  String? name;
  int? subjectId;
  int? mentorId;
  String? sort;

  CertificateDTO(
      {this.id,
      this.imageUrl,
      this.name,
      this.subjectId,
      this.mentorId,
      this.sort});

  CertificateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    subjectId = json['subjectId'];
    mentorId = json['mentorId'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['subjectId'] = this.subjectId;
    data['mentorId'] = this.mentorId;
    data['sort'] = this.sort;
    return data;
  }
}
