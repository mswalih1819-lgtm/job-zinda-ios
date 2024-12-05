class Comments {
  String? sId;
  String? post;
  CommentedBy? commentedBy;
  String? createdAt;
  String? comment;
  int? iV;

  Comments(
      {this.sId,
      this.post,
      this.commentedBy,
      this.createdAt,
      this.comment,
      this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    post = json['post'];
    commentedBy = json['commentedBy'] != null
        ? new CommentedBy.fromJson(json['commentedBy'])
        : null;
    createdAt = json['createdAt'];
    comment = json['comment'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['post'] = this.post;
    if (this.commentedBy != null) {
      data['commentedBy'] = this.commentedBy!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['comment'] = this.comment;
    data['__v'] = this.iV;
    return data;
  }
}

class CommentedBy {
  String? sId;
  String? name;
  String? profileImageUrl;

  CommentedBy({this.sId, this.name, this.profileImageUrl});

  CommentedBy.fromJson(Map<String, dynamic> json) {
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