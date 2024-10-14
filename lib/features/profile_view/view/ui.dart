import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_icon_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/chat_section/chat_pages/view/ui.dart';
import 'package:jora_customer/features/profile_view/view/widgets/profile_view_body.dart';
import 'package:jora_customer/features/wrapper/view_model/view_model.dart';
import 'package:provider/provider.dart';

class ProfileViewUi extends StatelessWidget {
  const ProfileViewUi({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        context.read<WrapperViewModel>().updatePageView(WrapperViewStatus.profile);
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomElavatedTextButton(
          bgcolor: PColors.white,
          textColor: PColors.black,
          borderRadius: 0,
          text: "Lets go",
          onPressed: () {},
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              head(context),
              SizedBox(
                height: 6,
              ),
              Divider(
                color: PColors.whiteOff.withOpacity(0.3),
              ),
              SizedBox(height: 10,),
              ProfileViewBodyUi(),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }

  Widget head(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              CircleAvatar(
                radius: 46,
                backgroundColor: PColors.white,
                child: CircleAvatar(
                  radius:44,
                  backgroundImage: AssetImage(PImages.pro_pic3),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              textWidget(text: "John Abraham"),
              SizedBox(
                height: 2,
              ),
              textWidget(
                  text: "Usermail@gmail.com",
                  fontsize: 12,
                  color: PColors.white.withOpacity(0.6))
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, PPages.editProfileUi);
                },
                child: SvgPicture.asset(PSvgs.edit_profile)),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
