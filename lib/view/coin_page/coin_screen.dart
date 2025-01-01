import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class CoinScreenUi extends StatelessWidget {
  const CoinScreenUi({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.read<ProfileViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Coins"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(PImages.coin),
                  const SizedBox(
                    width: 10,
                  ),
                  textWidget(
                      text: "${profileViewModel.profileModel!.coinBalance.toString()} Coins",
                      fontsize: 20,
                      fontweight: FontWeight.bold),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.info_outline, color: PColors.whiteOff.withOpacity(0.5),),
                  const SizedBox(
                    width:7,
                  ),
                  Expanded(
                    child: textWidget(
                      color: PColors.whiteOff.withOpacity(0.5),
                        text:
                            "Coins will be credited at the month end and the balance will be updated"),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
