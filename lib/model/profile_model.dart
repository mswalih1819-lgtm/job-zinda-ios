class ProfileModel {
  Location? location;
  String? sId;
  bool? getNotifications;
  String? name;
  String? email;
  String? countryCode;
  String? mobileNumber;
  String? profileImageUrl;
  String? gender;
  String? professionId;
  String? profession;
  String? bio;
  num? followersCount;
  num? projectsCount;
  num? rating;
  num? lat;
  num? lng;
  String? address;
  String? zipcode;
  bool? isVerified;
  String? accountType;
  List<Null>? fcmTokens;
  String? createdAt;
  String? coverImage;
  bool?isFollowing;

  ProfileModel(
      {this.location,
      this.sId,
      this.getNotifications,
      this.name,
      this.email,
      this.countryCode,
      this.mobileNumber,
      this.profileImageUrl,
      this.gender,
      this.professionId,
      this.profession,
      this.bio,
      this.followersCount,
      this.projectsCount,
      this.rating,
      this.lat,
      this.lng,
      this.address,
      this.zipcode,
      this.isVerified,
      this.accountType,
      this.fcmTokens,
      this.createdAt,
      this.coverImage , this.isFollowing});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    getNotifications = json['getNotifications'];
    name = json['name'];
    email = json['email'];
    countryCode = json['countryCode'];
    mobileNumber = json['mobileNumber'];
    profileImageUrl = json['profileImageUrl'];
    gender = json['gender'];
    professionId = json['professionId'];
    profession = json['profession'];
    bio = json['bio'];
    followersCount = json['followersCount'];
    projectsCount = json['projectsCount'];
    rating = json['rating'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    zipcode = json['zipcode'];
    isVerified = json['isVerified'];
    accountType = json['accountType'];
    createdAt = json['createdAt'];
    coverImage = json['coverImage'];
    isFollowing=json['isFollowing'];
  }
}

class Location {
  String? type;
  List<num>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<num>();
  }
}
