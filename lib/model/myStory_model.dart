class MyStoryModel {
  String? sId;
  User? user;
  String? notificationType;
  List<Media>? media;
  String? description;
  String? caption;
  bool? archived;
  bool? isActive;
  String? createdAt;
  String? lastUploadedMedia;
  int? iV;

  MyStoryModel(
      {this.sId,
      this.user,
      this.notificationType,
      this.media,
      this.description,
      this.caption,
      this.archived,
      this.isActive,
      this.createdAt,
      this.lastUploadedMedia,
      this.iV});

  MyStoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    notificationType = json['notificationType'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    description = json['description'];
    caption = json['caption'];
    archived = json['archived'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    lastUploadedMedia = json['lastUploadedMedia'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['notificationType'] = this.notificationType;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['caption'] = this.caption;
    data['archived'] = this.archived;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['lastUploadedMedia'] = this.lastUploadedMedia;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? profileImageUrl;

  User({this.sId, this.name, this.profileImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profileImageUrl'] = this.profileImageUrl;
    return data;
  }
}

class Media {
  String? mediaType;
  String? content;
  int? duration;
  String? postedAt;
  String? sId;

  Media({this.mediaType, this.content, this.duration, this.postedAt, this.sId});

  Media.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    content = json['content'];
    duration = json['duration'];
    postedAt = json['postedAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaType'] = this.mediaType;
    data['content'] = this.content;
    data['duration'] = this.duration;
    data['postedAt'] = this.postedAt;
    data['_id'] = this.sId;
    return data;
  }
}