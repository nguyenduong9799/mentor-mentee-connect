class UserWallet {
  int? id;
  String? name;
  bool? isSubscribed;
  String? phone;
  String? email;
  int? gender;
  String? birthDay;
  String? picUrl;
  double? point;
  String? refCode;

  UserWallet(
      {this.id,
      this.name,
      this.isSubscribed,
      this.phone,
      this.email,
      this.gender,
      this.birthDay,
      this.picUrl,
      this.point,
      this.refCode});

  UserWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSubscribed = json['isSubscribed'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    birthDay = json['birthDay'];
    picUrl = json['picUrl'];
    point = json['point'];
    refCode = json['refCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isSubscribed'] = this.isSubscribed;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['birthDay'] = this.birthDay;
    data['picUrl'] = this.picUrl;
    data['point'] = this.point;
    data['refCode'] = this.refCode;
    return data;
  }
}
