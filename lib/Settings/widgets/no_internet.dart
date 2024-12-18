
import 'package:flutter/material.dart';
import 'package:jora_customer/Data/Network/network_controller.dart';
import 'package:jora_customer/Settings/until/PPages.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off),
              Text("Check your Internet connectivity!!!"),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    NetConnection.networkConnection(context)
                        .then((value) async {
                      if (value == true) {
                        Navigator.pushReplacementNamed(
                            context, PPages.wrapperView);
                      }
                    });
                  },
                  child: Icon(Icons.refresh))
            ],
          ),
        ),
      ),
    );
  }
}
