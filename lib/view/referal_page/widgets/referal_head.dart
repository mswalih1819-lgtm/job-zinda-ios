import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferalHeadUi extends StatelessWidget {
  const ReferalHeadUi({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel=context.read<ProfileViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(text: "Your Referral ID", color: PColors.whiteOff),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: PColors.whiteOff)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                textWidget(text: profileViewModel.profileModel!.referralCode.toString()),
                const Spacer(),
                GestureDetector(
                  onTap: ()async{
                        try {
                      await Clipboard.setData(
                          ClipboardData(text: profileViewModel.profileModel!.referralCode.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Copied to clipboard!!!'),
                      ));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to copy to clipboard.')),
                      );
                    }
                  },
                  child: const Icon(Icons.copy)),
                const SizedBox(width: 8,),
                GestureDetector(
                  onTap: (){
                     Share.share(profileViewModel.profileModel!.referralCode.toString());
                  },
                  child: const Icon(Icons.share))
              ],
            ),
          ),
        )
      ],
    );
  }
}
