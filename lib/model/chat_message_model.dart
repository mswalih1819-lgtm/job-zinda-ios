

class ChatMessageModel {
  String? sId;
  String? conversationId;
  SenderId? senderId;
  String? content;
  String? messageType;
  List<String>? attachments;
  String? createdAt;
  int? iV;

  ChatMessageModel(
      {this.sId,
      this.conversationId,
      this.senderId,
      this.content,
      this.messageType,
      this.attachments,
      this.createdAt,
      this.iV});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    conversationId = json['conversationId'];
    senderId = json['senderId'] != null
        ? new SenderId.fromJson(json['senderId'])
        : null;
    content = json['content'];
    messageType = json['messageType'];
    if (json['attachments'] != null) {
      attachments = <String>[];
      json['attachments'].forEach((v) {
        attachments!.add(v);
      });
    }
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['conversationId'] = this.conversationId;
    if (this.senderId != null) {
      data['senderId'] = this.senderId!.toJson();
    }
    data['content'] = this.content;
    data['messageType'] = this.messageType;
     if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v).toList();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SenderId {
  String? sId;
  String? name;
  String? profileImageUrl;

  SenderId({this.sId, this.name, this.profileImageUrl});

  SenderId.fromJson(Map<String, dynamic> json) {
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



