import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/widgets/result_sheet.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/widgets/simple_map.dart';
import 'package:jora_customer/view/connect_pages/map_section/view_model/view_model.dart';
import 'package:provider/provider.dart';

class ConnectPagesUi extends StatefulWidget {
  @override
  _ConnectPagesUiState createState() => _ConnectPagesUiState();
}

class _ConnectPagesUiState extends State<ConnectPagesUi> {
  int? tappedIndex;
  GoogleMapController? mapController;
  LatLng _center = const LatLng(
      37.7749, -122.4194); // San Francisco coordinates as an example
  double _radius = 10000; // default radius in meters
  List<LatLng> _photographers = [
    LatLng(37.7799, -122.4194), // Sample photographer locations
    LatLng(37.7749, -122.4294),
    LatLng(37.7699, -122.4394),
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _updateRadius(double radius) {
    setState(() {
      _radius = radius;
    });
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    return Geolocator.distanceBetween(
      point1.latitude,
      point1.longitude,
      point2.latitude,
      point2.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: TextField(
      //   //   decoration: InputDecoration(
      //   //     hintText: 'Search for Photographer',
      //   //     border: OutlineInputBorder(),
      //   //   ),
      //   // ),
      // ),
      // body: Stack(
      //   children: [
      //     GoogleMap(
      //       onMapCreated: _onMapCreated,
      //       initialCameraPosition: CameraPosition(
      //         target: _center,
      //         zoom: 12.0,
      //       ),
      //       markers: _photographers
      //           .where((photographer) => calculateDistance(_center, photographer) <= _radius)
      //           .map((photographer) => Marker(
      //                 markerId: MarkerId(photographer.toString()),
      //                 position: photographer,
      //               ))
      //           .toSet(),
      //       circles: {
      //         Circle(
      //           circleId: CircleId('radius_circle'),
      //           center: _center,
      //           radius: _radius,
      //           fillColor: Colors.blue.withOpacity(0.1),
      //           strokeWidth: 1,
      //         ),
      //       },
      //     ),
      //     Positioned(
      //       bottom: 20,
      //       left: 20,
      //       right: 20,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           ElevatedButton(
      //             onPressed: () => _updateRadius(10000), // 10 km
      //             child: Text('10 km'),
      //           ),
      //           ElevatedButton(
      //             onPressed: () => _updateRadius(15000), // 15 km
      //             child: Text('15 km'),
      //           ),
      //           ElevatedButton(
      //             onPressed: () => _updateRadius(20000), // 20 km
      //             child: Text('20 km'),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),

      body: Stack(
        children: [
          SimpleMap(),
          ChangeNotifierProvider(
              create: (context) => MapViewModel(),
              builder: (context, child) {
                var model = context.read<MapViewModel>();
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  child: CustomTextFeild(
                      suffixIcon: Visibility(
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: PColors.white,
                        ),
                        visible: model.onChanged,
                      ),
                      sufixfn: () {},
                      hintColor: PColors.white,
                      borderRadius: 4,
                      borderColor: PColors.textFieldColor,
                      textColor: PColors.white,
                      prefixIcon: Icon(
                        Icons.person,
                        color: PColors.white,
                      ),
                      prefixfn: () {},
                      hintText: "Type a skill or role",
                      onSaved: (val) {},
                      onChanged: (val) {
                        model.updateTextfieldChange(true);
                      },
                      validation: (val) {},
                      filColor: PColors.textFieldColor),
                );
              }),
          Positioned(
            // bottom: 20,
            top: 115,
            left: 10,
            right: 10,
            child: Container(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   setState(() {
                    //     tappedIndex = index;
                    //   });
                    //   print(tappedIndex);
                    // });

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tappedIndex = index;
                        });
                        showModalBottomSheet(
                          // shape: Border(),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => ResultSheetUi(),
                        );
                      },
                      child: kmWidget(
                          title: list[index], selected: tappedIndex == index),
                    );
                  }),
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            // ElevatedButton(
            //   onPressed: () => _updateRadius(10000), // 10 km
            //   child: Text('10 km'),
            // ),
            // ElevatedButton(
            //   onPressed: () => _updateRadius(15000), // 15 km
            //   child: Text('15 km'),
            // ),
            // ElevatedButton(
            //   onPressed: () => _updateRadius(20000), // 20 km
            //   child: Text('20 km'),
            // ),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }

  Widget kmWidget(
      {required String title,
      // required Function()? fun,
      required bool selected}) {
    return Container(
      width: 130,
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: selected ? PColors.black : PColors.kmColor.withOpacity(0.7)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Center(
          child: textWidget(
              text: "${title}Km",
              color: selected ? PColors.white : Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }

  List list = ["10", "15", "20", "25"];
}
