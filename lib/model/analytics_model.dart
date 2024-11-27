class AnalyticsModel {
  int? totalFollowers;
  int? filteredFollowers;
  String? followersGrowth;
  int? unFollowCount;
  int? totalProfileViews;
  int? totalProjects;
  TotalFeedback? totalFeedback;

  AnalyticsModel(
      {this.totalFollowers,
      this.filteredFollowers,
      this.followersGrowth,
      this.unFollowCount,
      this.totalProfileViews,
      this.totalProjects,
      this.totalFeedback});

  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['totalFollowers'];
    filteredFollowers = json['filteredFollowers'];
    followersGrowth = json['followersGrowth'];
    unFollowCount = json['unFollowCount'];
    totalProfileViews = json['totalProfileViews'];
    totalProjects = json['totalProjects'];
    totalFeedback = json['totalFeedback'] != null
        ? new TotalFeedback.fromJson(json['totalFeedback'])
        : null;
  }

}

class TotalFeedback {
  double? averageRating;
  int? totalRatings;

  TotalFeedback({this.averageRating, this.totalRatings});

  TotalFeedback.fromJson(Map<String, dynamic> json) {
    averageRating = json['averageRating'];
    totalRatings = json['totalRatings'];
  }


}
