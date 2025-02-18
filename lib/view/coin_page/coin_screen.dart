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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                     Text(
                "You will receive 100 Jora coins after a successful referral...",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20), // Spacing
            
              Text(
                "Now, this feature can only be used by registered Jora promoters...",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
            
              Text(
                "To register:",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 10),
            
              Text(
                "• Chat with a current Jora promoter, or\n"
                "• Chat with the official Jora account...",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 20),
            
              Text(
                "100 Jora coins = 10 Rupees",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 10),
            
              Text(
                "(Coin value will change when demand increases..)",
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
            
              Text(
                "You can withdraw Jora coins by chatting with the official Jora account..",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 20),
            
              Text(
                "Any fraudulent activity will result in the removal of your account from the app... without any warning...",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              ],
            ),
          ),
        ));
  }
}
