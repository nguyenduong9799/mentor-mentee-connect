class MajorDTO {
  int? id;
  String? name;
  String? imageUrl;
  String? sort;

  MajorDTO({this.id, this.name, this.imageUrl, this.sort});

  MajorDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['sort'] = this.sort;
    return data;
  }

  static List<MajorDTO> fromList(dynamic jsonList) {
    var list = jsonList as List;
    return list.map((map) => MajorDTO.fromJson(map)).toList();
  }
}
