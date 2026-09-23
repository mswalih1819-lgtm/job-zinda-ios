class ExperienceModel {
  String title;
  String company;
  String duration;
  String description;
  bool isCurrent;

  ExperienceModel({
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
    this.isCurrent = false,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      title: json['title']?.toString() ?? '',
      company: json['company']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isCurrent: json['isCurrent'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'duration': duration,
      'description': description,
      'isCurrent': isCurrent,
    };
  }
}
