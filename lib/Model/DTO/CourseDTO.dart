import 'package:mentor_mentee_connecting/Model/DTO/AccountDTO.dart';

import 'SubjectDTO.dart';

class CourseDTO {
  int? id;
  String? name;
  int? minQuantity;
  int? maxQuantity;
  int? price;
  String? slug;
  String? imageUrl;
  String? startDate;
  String? updateDate;
  String? createDate;
  String? finishDate;
  int? status;
  bool? isActive;
  int? type;
  int? locationType;
  String? location;
  String? description;
  int? totalRating;
  int? mentorId;
  AccountDTO? mentor;
  int? subjectId;
  SubjectDTO? subject;
  String? sort;

  CourseDTO(
      {this.id,
      this.name,
      this.minQuantity,
      this.maxQuantity,
      this.price,
      this.slug,
      this.imageUrl,
      this.startDate,
      this.updateDate,
      this.createDate,
      this.finishDate,
      this.status,
      this.isActive,
      this.type,
      this.locationType,
      this.location,
      this.description,
      this.totalRating,
      this.mentorId,
      this.mentor,
      this.subjectId,
      this.subject,
      this.sort});

  CourseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minQuantity = json['minQuantity'];
    maxQuantity = json['maxQuantity'];
    price = json['price'];
    slug = json['slug'];
    imageUrl = json['imageUrl'];
    startDate = json['startDate'];
    updateDate = json['updateDate'];
    createDate = json['createDate'];
    finishDate = json['finishDate'];
    status = json['status'];
    isActive = json['isActive'];
    type = json['type'];
    locationType = json['locationType'];
    location = json['location'];
    description = json['description'];
    totalRating = json['totalRating'];
    mentorId = json['mentorId'];
    mentor =
        json['mentor'] != null ? new AccountDTO.fromJson(json['mentor']) : null;
    subjectId = json['subjectId'];
    subject = json['subject'] != null
        ? new SubjectDTO.fromJson(json['subject'])
        : null;
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['minQuantity'] = this.minQuantity;
    data['maxQuantity'] = this.maxQuantity;
    data['price'] = this.price;
    data['slug'] = this.slug;
    data['imageUrl'] = this.imageUrl;
    data['startDate'] = this.startDate;
    data['updateDate'] = this.updateDate;
    data['createDate'] = this.createDate;
    data['finishDate'] = this.finishDate;
    data['status'] = this.status;
    data['isActive'] = this.isActive;
    data['type'] = this.type;
    data['locationType'] = this.locationType;
    data['location'] = this.location;
    data['description'] = this.description;
    data['totalRating'] = this.totalRating;
    data['mentorId'] = this.mentorId;
    if (this.mentor != null) {
      data['mentor'] = this.mentor!.toJson();
    }
    data['subjectId'] = this.subjectId;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    data['sort'] = this.sort;
    return data;
  }
}
