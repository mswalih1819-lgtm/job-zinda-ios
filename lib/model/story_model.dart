import 'package:jora_customer/model/myStory_model.dart';

class StoryModel {
  String? sId;
  String? user;
  String? notificationType;
  List<Media>? media;
  String? description;
  String? caption;
  bool? archived;
  bool? isActive;
  String? createdAt;
  String? lastUploadedMedia;
  int? iV;
  String? userName;
  String? userProfileImg;

  StoryModel(
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
      this.iV,
      this.userName,
      this.userProfileImg});

  StoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
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
    userName = json['userName'];
    userProfileImg = json['userProfileImg'];
  }


}

// class Media {
//   String? mediaType;
//   String? content;
//   int? duration;
//   String? postedAt;
//   String? sId;

//   Media({this.mediaType, this.content, this.duration, this.postedAt, this.sId});

//   Media.fromJson(Map<String, dynamic> json) {
//     mediaType = json['mediaType'];
//     content = json['content'];
//     duration = json['duration'];
//     postedAt = json['postedAt'];
//     sId = json['_id'];
//   }

// }
