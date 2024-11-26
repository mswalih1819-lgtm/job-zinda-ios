class ConversationModel {
  String? sId;
  List<Participants>? participants;
  LastMessage? lastMessage;
  String? createdUser;
  int? iV;

  ConversationModel(
      {this.sId,
      this.participants,
      this.lastMessage,
      this.createdUser,
      this.iV});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    createdUser = json['createdUser'];
    iV = json['__v'];
  }


}

class Participants {
  String? userId;
  String? lastReadMessageId;
  String? sId;

  Participants({this.userId, this.lastReadMessageId, this.sId});

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    lastReadMessageId = json['lastReadMessageId'];
    sId = json['_id'];
  }


}

class LastMessage {
  String? sId;
  String? createdAt;
  String? content;
  MessageId? messageId;
  String? senderId;

  LastMessage(
      {this.sId, this.createdAt, this.content, this.messageId, this.senderId});

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    content = json['content'];
    messageId = json['messageId'] != null
        ? new MessageId.fromJson(json['messageId'])
        : null;
    senderId = json['senderId'];
  }

}

class MessageId {
  String? sId;
  String? conversationId;
  String? senderId;
  String? content;
  String? messageType;
  int? iV;

  MessageId(
      {this.sId,
      this.conversationId,
      this.senderId,
      this.content,
      this.messageType,
      this.iV});

  MessageId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    conversationId = json['conversationId'];
    senderId = json['senderId'];
    content = json['content'];
    messageType = json['messageType'];
    iV = json['__v'];
  }


}
