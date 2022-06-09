class AccountDTO {
  int? id;
  String? fullName;
  int? gender;
  String? imageUrl;
  String? phone;
  String? email;
  String? address;
  String? dayOfBirth;
  bool? isFirstLogin;
  int? status;
  int? badge;
  int? roleId;

  AccountDTO(
      {this.id,
      this.fullName,
      this.gender,
      this.imageUrl,
      this.phone,
      this.email,
      this.isFirstLogin,
      this.address,
      this.dayOfBirth,
      this.status,
      this.badge,
      this.roleId});

  AccountDTO.fromJson(Map<String, dynamic> json) {
    id = json['userId'];
    fullName = json['name'];
    gender = json['gender'];
    imageUrl = json['imageUrl'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    isFirstLogin = json['isFirstLogin'];
    dayOfBirth = json['dayOfBirth'];
    status = json['status'];
    badge = json['badge'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.id;
    data['name'] = this.fullName;
    data['gender'] = this.gender;
    data['imageUrl'] = this.imageUrl;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['isFirstLogin'] = this.isFirstLogin;
    data['address'] = this.address;
    data['dayOfBirth'] = this.dayOfBirth;
    data['status'] = this.status;
    data['badge'] = this.badge;
    data['roleId'] = this.roleId;
    return data;
  }
}
