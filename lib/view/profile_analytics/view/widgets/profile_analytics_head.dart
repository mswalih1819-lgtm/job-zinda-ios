import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/analytics_model.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/utils/date_formatter.dart';
import 'package:jora_customer/view/wrapper/view/widgets/wrapper_body.dart';
import 'package:jora_customer/view_model/profile_analytics_view_model.dart';
import 'package:provider/provider.dart';

class ProfileAnalyticsHeadUi extends StatefulWidget {
  ProfileAnalyticsHeadUi({super.key});

  @override
  State<ProfileAnalyticsHeadUi> createState() => _ProfileAnalyticsHeadUiState();
}

class _ProfileAnalyticsHeadUiState extends State<ProfileAnalyticsHeadUi> {
  String dropdownValue = 'Last 7 days';

  @override
  Widget build(BuildContext context) {
    ProfileAnalyticsViewModel profileAnalyticsViewModel =
        context.watch<ProfileAnalyticsViewModel>();
    AnalyticsModel? analyticsModel = profileAnalyticsViewModel.analyticsModel;
    String today =
        formatDateFromDate(dateTime: DateTime.now(), format: 'MMM dd');
    String beforeOneMonth = formatDateFromDate(
        dateTime: DateTime.now().subtract(Duration(days: 30)),
        format: 'MMM dd');
    String beforeOneWeek = formatDateFromDate(
        dateTime: DateTime.now().subtract(Duration(days: 7)), format: 'MMM dd');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dropdownWidget(),
              Text(
                '${dropdownValue == 'Last 7 days' ? beforeOneWeek : beforeOneMonth} - $today',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: PColors.white,
                child: CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        NetworkImage(LoggedInUser.profilePic ?? '')),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: 'Total followers',
                    color: PColors.whiteOff.withOpacity(0.9),
                  ),
                  Row(
                    children: [
                      Text(
                        '${analyticsModel?.totalFollowers ?? '0'} ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green[100],
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                            size: 13,
                          ),
                        ),
                      ),
                      Text(
                        ' ${analyticsModel?.followersGrowth ?? '0%'}',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget dropdownWidget() {
    return Container(
      height: 38,
      decoration: BoxDecoration(
          color: PColors.black2, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<String>(
          value: dropdownValue,
          dropdownColor: PColors.seed2,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: PColors.white,
          ),
          //
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: PColors.seed2),
          underline: Container(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                dropdownValue = newValue;
              });
              if (newValue == 'Last 7 days') {
                context
                    .read<ProfileAnalyticsViewModel>()
                    .fetchProfileAnalytics(filter: '7days');
              } else {
                context
                    .read<ProfileAnalyticsViewModel>()
                    .fetchProfileAnalytics(filter: '1month');
              }
            }
          },
          items: <String>['Last 7 days', 'Last 1 month']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: textWidget(text: value, color: PColors.white),
            );
          }).toList(),
        ),
      ),
    );
  }
}
