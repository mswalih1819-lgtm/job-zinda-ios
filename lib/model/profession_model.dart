class ProfessionModel {
  String? sId;
  String? name;
  int? sortNumber;

  ProfessionModel({this.sId, this.name, this.sortNumber});

  ProfessionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    sortNumber = json['sortNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['sortNumber'] = this.sortNumber;
    return data;
  }
}