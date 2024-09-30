import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class ProfileAnalyticsHeadUi extends StatefulWidget {
  ProfileAnalyticsHeadUi({super.key});

  @override
  State<ProfileAnalyticsHeadUi> createState() => _ProfileAnalyticsHeadUiState();
}

class _ProfileAnalyticsHeadUiState extends State<ProfileAnalyticsHeadUi> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dropdownWidget(),
              Text(
                'Sep 14 - Sep 20',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 30),

          // Profile and followers
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: PColors.white,
                child: CircleAvatar(
                    radius: 28, backgroundImage: AssetImage(PImages.pro_pic3)),
                // Replace with your image
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
                        '1.5k ',
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
                        '10.2%',
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
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: PColors.seed2),
          underline: Container(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Last 7 days', 'Last 3 days']
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
