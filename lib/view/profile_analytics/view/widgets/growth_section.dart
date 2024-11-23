import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class GrowthSectionUi extends StatelessWidget {
  const GrowthSectionUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 19),

          textWidget(
            text:'Growth',
            color: PColors.white,fontsize: 18,fontweight: FontWeight.w600
          ),
          SizedBox(height: 10),
          itemWidget(title: 'Total new followers', value: '23'),
          SizedBox(height: 10,),
          itemWidget(title: 'Unfollows', value: '3'),
          SizedBox(height: 10,),

          itemWidget(title: 'Profile view', value: '3'),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget itemWidget({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.white,fontSize: 16),
        ),
      ],
    );
  }
}
