class Referrals {
  String? sId;
  bool? documentStatus;
  String? referralCode;
  String? referrer;
  ReferredUser? referredUser;
  int? referralCoins;
  String? claimStatus;
  String? createdAt;
  int? iV;

  Referrals(
      {this.sId,
      this.documentStatus,
      this.referralCode,
      this.referrer,
      this.referredUser,
      this.referralCoins,
      this.claimStatus,
      this.createdAt,
      this.iV});

  Referrals.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    documentStatus = json['documentStatus'];
    referralCode = json['referralCode'];
    referrer = json['referrer'];
    referredUser = json['referredUser'] != null
        ? new ReferredUser.fromJson(json['referredUser'])
        : null;
    referralCoins = json['referralCoins'];
    claimStatus = json['claimStatus'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['documentStatus'] = this.documentStatus;
    data['referralCode'] = this.referralCode;
    data['referrer'] = this.referrer;
    if (this.referredUser != null) {
      data['referredUser'] = this.referredUser!.toJson();
    }
    data['referralCoins'] = this.referralCoins;
    data['claimStatus'] = this.claimStatus;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ReferredUser {
  String? sId;
  String? name;
  String? email;
  String? profileImageUrl;
  String? referralCode;

  ReferredUser(
      {this.sId,
      this.name,
      this.email,
      this.profileImageUrl,
      this.referralCode});

  ReferredUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    profileImageUrl = json['profileImageUrl'];
    referralCode = json['referralCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profileImageUrl'] = this.profileImageUrl;
    data['referralCode'] = this.referralCode;
    return data;
  }
}