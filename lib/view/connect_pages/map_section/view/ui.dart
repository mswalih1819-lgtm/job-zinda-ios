import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/widgets/result_sheet.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/widgets/simple_map.dart';
import 'package:jora_customer/view_model/connect_page_view_model.dart';
import 'package:provider/provider.dart';

class ConnectPagesUi extends StatefulWidget {
  @override
  _ConnectPagesUiState createState() => _ConnectPagesUiState();
}

class _ConnectPagesUiState extends State<ConnectPagesUi> {
  int? tappedIndex;
  GoogleMapController? mapController;
  TextEditingController txetController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    ConnectPageViewModel connectPageViewModel =
        context.watch<ConnectPageViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // Map widget
          SimpleMap(),

          // Positioned Row with TextField and Icon
          Positioned(
            top: 50, // You can adjust this to position the row as needed
            left: 10,
            right: 10,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFeild(
                    suffixIcon: Visibility(
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: PColors.white,
                      ),
                      visible: true,
                    ),
                    sufixfn: () {
                      txetController.clear();
                      connectPageViewModel.updateSearchTag("");
                      connectPageViewModel.clear();
                    },
                    hintColor: PColors.white,
                    borderRadius: 4,
                    borderColor: PColors.textFieldColor,
                    textColor: PColors.white,
                    prefixIcon: Icon(
                      Icons.person,
                      color: PColors.white,
                    ),
                    prefixfn: () {},
                    controller: txetController,
                    hintText: "Type a role",
                    onSaved: (val) async {},
                    onChanged: (val) async {
                      connectPageViewModel.updateSearchTag(val!);
                    },
                    onSubmitted: (val) async {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => ResultSheetUi(),
                      );
                    },
                    validation: (val) {},
                    filColor: PColors.textFieldColor,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PPages.searchLocation,
                        arguments: "map");
                  },
                  child: Container(
                    height: 52,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: PColors.textFieldColor),
                    child: Icon(
                      Icons.location_on_sharp, // Search icon
                      color: PColors.red,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Positioned list of km options
          Positioned(
            top: 115, // Adjust this value based on where you want it
            left: 10,
            right: 10,
            child: Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        tappedIndex = index;
                      });
                      await connectPageViewModel
                          .updateDistanceInKm(list[index]);
                      await Future.delayed(Duration(seconds: 1));
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => ResultSheetUi(),
                      );
                    },
                    child: kmWidget(
                        title: list[index], selected: tappedIndex == index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget kmWidget({required String title, required bool selected}) {
    return Container(
      width: 130,
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: selected ? PColors.black : PColors.kmColor.withOpacity(0.7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: textWidget(
            text: "${title}Km",
            color: selected ? PColors.white : Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  List list = ["10", "20", "30"];
}
