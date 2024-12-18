class SubscriptionPaymentModel {
  double? amount;
  double? amountDue;
  double? amountPaid;
  int? attempts;
  int? createdAt;
  String? currency;
  String? entity;
  String? id;
  Notes? notes;
  String? offerId;
  String? receipt;
  String? status;
  String? keyId;

  SubscriptionPaymentModel(
      {this.amount,
      this.amountDue,
      this.amountPaid,
      this.attempts,
      this.createdAt,
      this.currency,
      this.entity,
      this.id,
      this.notes,
      this.offerId,
      this.receipt,
      this.status,
      this.keyId});

  SubscriptionPaymentModel.fromJson(Map<String, dynamic> json) {
    amount = double.parse(json['amount'].toString());
    amountDue = double.parse(json['amount_due'].toString());
    amountPaid = double.parse(json['amount_paid'].toString());
    attempts = json['attempts'];
    createdAt = json['created_at'];
    currency = json['currency'];
    entity = json['entity'];
    id = json['id'];
    notes = json['notes'] != null ? new Notes.fromJson(json['notes']) : null;
    offerId = json['offer_id'];
    receipt = json['receipt'];
    status = json['status'];
    keyId = json['key_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['amount_due'] = this.amountDue;
    data['amount_paid'] = this.amountPaid;
    data['attempts'] = this.attempts;
    data['created_at'] = this.createdAt;
    data['currency'] = this.currency;
    data['entity'] = this.entity;
    data['id'] = this.id;
    if (this.notes != null) {
      data['notes'] = this.notes!.toJson();
    }
    data['offer_id'] = this.offerId;
    data['receipt'] = this.receipt;
    data['status'] = this.status;
    data['key_id'] = this.keyId;
    return data;
  }
}

class Notes {
  String? email;
  String? fullName;
  String? phone;
  String? userId;

  Notes({this.email, this.fullName, this.phone, this.userId});

  Notes.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['userId'] = this.userId;
    return data;
  }
}
