class PostModel {
  String? sId;
  String? bio;
  String? mediaType;
  String? mediaUrl;
  int? duration;
  int? likesCount;
  int? commentsCount;
  int? shareCount;
  User? user;
  String? sharedWith;
  String? createdAt;
  bool?isLiked;

  PostModel(
      {this.sId,
      this.bio,
      this.mediaType,
      this.mediaUrl,
      this.duration,
      this.likesCount,
      this.commentsCount,
      this.shareCount,
      this.user,
      this.sharedWith,
      this.createdAt,this.isLiked});

  PostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bio = json['bio'];
    mediaType = json['mediaType'];
    mediaUrl = json['mediaUrl'];
    duration = json['duration'];
    likesCount = json['likesCount'];
    commentsCount = json['commentsCount'];
    shareCount = json['shareCount'];
    user = json['user'] != null && json['user'] is Map
        ? User.fromJson(json['user'])
        : User();
    sharedWith = json['sharedWith'];
    createdAt = json['createdAt'];
    isLiked =json.containsKey('isLiked')? json['isLiked']:null;

  }
}

class User {
  String? sId;
  String? userName;
  String? userProfilePicture;
  String? professionId;
  String? professionName;

  User(
      {this.sId,
      this.userName,
      this.userProfilePicture,
      this.professionId,
      this.professionName});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    userProfilePicture = json['userProfilePicture'];
    professionId = json['professionId'];
    professionName = json['professionName'];
  }
}
