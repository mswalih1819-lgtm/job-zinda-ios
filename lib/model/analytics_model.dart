class AnalyticsModel {
  int? totalFollowers;
  int? filteredFollowers;
  String? followersGrowth;
  int? unFollowCount;
  int? totalProfileViews;
  int? totalProjects;

  AnalyticsModel(
      {this.totalFollowers,
      this.filteredFollowers,
      this.followersGrowth,
      this.unFollowCount,
      this.totalProfileViews,
      this.totalProjects});

  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['totalFollowers'];
    filteredFollowers = json['filteredFollowers'];
    followersGrowth = json['followersGrowth'];
    unFollowCount = json['unFollowCount'];
    totalProfileViews = json['totalProfileViews'];
    totalProjects = json['totalProjects'];
  }


}
