class Plans {
  String? sId;
  String? planName;
  bool? documentStatus;
  double? amountMRP;
  double? amount;
  double? billableAmount;
  String? planAmountPer;
  double? discountPercentage;
  String? durationDays;
  String? planType;
  List<String>? planFeatures;
  String? currency;
  String? currencySymbol;
  String? planIcon;
  bool? isSubscribed;
  int? iV;

  Plans(
      {this.sId,
      this.planName,
      this.documentStatus,
      this.amountMRP,
      this.amount,
      this.billableAmount,
      this.planAmountPer,
      this.discountPercentage,
      this.durationDays,
      this.planType,
      this.planFeatures,
      this.currency,
      this.currencySymbol,
      this.planIcon,
      this.isSubscribed,
      this.iV});

  Plans.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['planName'];
    documentStatus = json['documentStatus'];
    amountMRP = double.parse(json['amountMRP'].toString());
    amount = double.parse(json['amount'].toString());
    billableAmount = double.parse(json['billableAmount'].toString());
    planAmountPer = json['planAmountPer'];
    discountPercentage = double.parse(json['discountPercentage'].toString());
    durationDays = json['durationDays'];
    planType = json['planType'];
    planFeatures = json['planFeatures'].cast<String>();
    currency = json['currency'];
    isSubscribed = json['isSubscribed'];
    currencySymbol = json['currencySymbol'];
    planIcon = json['planIcon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['planName'] = this.planName;
    data['documentStatus'] = this.documentStatus;
    data['amountMRP'] = this.amountMRP;
    data['amount'] = this.amount;
    data['billableAmount'] = this.billableAmount;
    data['planAmountPer'] = this.planAmountPer;
    data['discountPercentage'] = this.discountPercentage;
    data['durationDays'] = this.durationDays;
    data['planType'] = this.planType;
    data['isSubscribed'] = this.isSubscribed;
    data['planFeatures'] = this.planFeatures;
    data['currency'] = this.currency;
    data['currencySymbol'] = this.currencySymbol;
    data['planIcon'] = this.planIcon;
    data['__v'] = this.iV;
    return data;
  }
}
