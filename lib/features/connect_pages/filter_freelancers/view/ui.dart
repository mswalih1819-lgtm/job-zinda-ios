import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/features/connect_pages/filter_freelancers/view/widgets/distance_filter.dart';
import 'package:jora_customer/features/connect_pages/filter_freelancers/view/widgets/gender_filter_widget.dart';
import 'package:jora_customer/features/connect_pages/filter_freelancers/view/widgets/projects_filter.dart';
import 'package:jora_customer/features/connect_pages/filter_freelancers/view/widgets/rating_filter.dart';
import 'package:jora_customer/features/connect_pages/filter_freelancers/view_model/view_model.dart';
import 'package:provider/provider.dart';

class FreelancerFilterPageUi extends StatelessWidget {
   FreelancerFilterPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomElavatedTextButton(
        borderRadius: 0,
        text: "Save",onPressed: (){},bgcolor: PColors.white,textColor: PColors.black,),
      
      appBar: AppBar(title: Text("Filter",style: TextStyle(fontWeight: FontWeight.w400),),),body: Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: ChangeNotifierProvider(
        create: (context) => FreelancerFilterViewModel(),
        builder: (context, child) =>  SingleChildScrollView(
          child: Column(children: [
            DistanceFilterUi(),
            SizedBox(height: 10,),
            GenderFilterUi(),
            SizedBox(height: 10,),
        
            ProjectsFilterUi(),
            SizedBox(height: 10,),
        
            RatingFilterUi(),
            SizedBox(height: 40,),
        
          ],),
        ),
      ),
    ),);
  }

 

 
}