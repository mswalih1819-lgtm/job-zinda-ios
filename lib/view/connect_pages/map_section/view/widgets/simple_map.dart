import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/view/connect_pages/map_section/view/widgets/result_sheet.dart';
import 'package:jora_customer/view_model/connect_page_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class SimpleMap extends StatelessWidget {
  const SimpleMap({super.key});

  // final List<LatLng> points = [
  //   LatLng(8.5241, 76.9366), // San Francisco
  //   LatLng(9.9312, 76.2673), // Los Angeles
  //   LatLng(11.2588, 75.7804),  // New York
  // ];
  @override
  Widget build(BuildContext context) {
    ConnectPageViewModel connectPageViewModel =
        context.watch<ConnectPageViewModel>();
    ProfileViewModel profileViewModel = context.read<ProfileViewModel>();
    print("profile:-${profileViewModel.profileModel}");
    return Consumer<ConnectPageViewModel>(
      builder: (context, value, child) => FlutterMap(
        mapController: value.mapController,
        options: MapOptions(
            onMapReady: value.onMapReady,
            initialCenter: LatLng(value.lat!, value.lng!), //
            // initialCenter: LatLng(
            //     profileViewModel.profileModel!.lat!.toDouble(),
            //     profileViewModel.profileModel!.lng!
            //         .toDouble()), // Updated parameter for initial center
            initialZoom: 15 // Updated parameter for initial zoom
            ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            // urlTemplate: "https://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png",
            userAgentPackageName: "com.example.app",
            subdomains: const ['a', 'b', 'c'],
            // attributionBuilder: (_) {
            //   return Text("© OpenStreetMap contributors");
            // },
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                  point: LatLng(value.lat!, value.lng!),
                  radius:
                      // connectPageViewModel.distanceInKm.isNotEmpty
                      // ?
                      double.parse(connectPageViewModel.distanceInKm) * 10,
                  // : 1, // Radius in meters
                  color:
                      const Color.fromARGB(255, 170, 174, 176).withOpacity(0.1),
                  borderStrokeWidth: 2,
                  borderColor: PColors.mapCircleborder),
            ],
          ),
          MarkerLayer(
              markers: connectPageViewModel.nearestProfiles
                  .map(
                    (e) => Marker(
                        width: 60,
                        height: 60,
                        point: LatLng(e.lat!, e.lng!),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              // shape: Border(),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => ResultSheetUi(),
                            );
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                const Color.fromARGB(255, 153, 220, 229),
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: PColors.black,
                              //  backgroundImage:    AssetImage(PImages.profile)
                              backgroundImage: e.profileImageUrl!.isEmpty
                                  ? AssetImage(PImages.profile)
                                  : NetworkImage(e.profileImageUrl!),
                            ),
                          ),
                        )),
                  )
                  .toList()),

          // MarkerLayer(
          //   markers: points.map((point) {
          //     return Marker(
          //       point: point,
          //       width: 50, // Width of the image
          //       height: 50, // Height of the image
          //       child: GestureDetector(
          //         onTap: () {
          //           // Handle marker tap
          //           print("Marker at $point tapped!");
          //         },
          //         child: Image.asset(PImages.profile), // Custom image
          //       ),
          //     );
          //   }).toList(),
          // ),
          MarkerLayer(markers: [
            Marker(
                point:
                    LatLng(value.lat!, value.lng!), // Location for the marker
                // width: 80.0,
                // height: 80.0,

                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: PColors.black.withOpacity(0.2),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: PColors.white,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: PColors.black,
                    ),
                  ),
                )),
          ])
        ],
      ),
    );
  }
}
// class SimpleMap extends StatefulWidget {
//   const SimpleMap({super.key});

//   @override
//   _SimpleMapState createState() => _SimpleMapState();
// }

// class _SimpleMapState extends State<SimpleMap> {
//   double _zoomLevel = 15; // Initial zoom level

//   @override
//   Widget build(BuildContext context) {
//     ConnectPageViewModel connectPageViewModel =
//         context.watch<ConnectPageViewModel>();
//     ProfileViewModel profileViewModel = context.read<ProfileViewModel>();

//     return Consumer<ConnectPageViewModel>(
//       builder: (context, value, child) => FlutterMap(
//         mapController: value.mapController,
//         options: MapOptions(
//           onMapReady: value.onMapReady,
//           initialCenter: LatLng(value.lat!, value.lng!),
//           initialZoom: _zoomLevel, // Set initial zoom level
//           onPositionChanged: (position, hasGesture) {
//             setState(() {
//               _zoomLevel = position.zoom; // Update the zoom level
//             });
//           },
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//             userAgentPackageName: "com.example.app",
//             subdomains: const ['a', 'b', 'c'],
//           ),
//           CircleLayer(
//             circles: [
//               CircleMarker(
//                 point: LatLng(value.lat!, value.lng!),
//                 radius:
//                     _calculateRadiusInPixels(connectPageViewModel.distanceInKm),
//                 color:
//                     Color.fromARGB(128, 170, 174, 176), // Semi-transparent grey
//                 borderStrokeWidth: 2,
//                 borderColor:
//                     Color.fromARGB(255, 170, 174, 176), // Solid grey border
//               ),
//             ],
//           ),
//           MarkerLayer(
//             markers: connectPageViewModel.nearestProfiles
//                 .map(
//                   (e) => Marker(
//                     width: 60,
//                     height: 60,
//                     point: LatLng(e.lat!, e.lng!),
//                     child: GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet(
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (context) => ResultSheetUi(),
//                         );
//                       },
//                       child: CircleAvatar(
//                         radius: 25,
//                         backgroundColor:
//                             const Color.fromARGB(255, 153, 220, 229),
//                         child: CircleAvatar(
//                           radius: 26,
//                           backgroundColor: PColors.black,
//                           backgroundImage: e.profileImageUrl!.isEmpty
//                               ? AssetImage(PImages.profile)
//                               : NetworkImage(e.profileImageUrl!),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 point: LatLng(value.lat!, value.lng!),
//                 child: CircleAvatar(
//                   radius: 10,
//                   backgroundColor: PColors.black.withOpacity(0.2),
//                   child: CircleAvatar(
//                     radius: 8,
//                     backgroundColor: PColors.white,
//                     child: CircleAvatar(
//                       radius: 6,
//                       backgroundColor: PColors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

// double _calculateRadiusInPixels(String distanceInKm) {
//   double km = double.parse(distanceInKm); // Convert km to a double
//   double meters = km * 1000; // Convert km to meters

//   // Define the scale factor to control how the radius scales on the map
//   double pixelsPerMeter = _metersToPixelsAtZoom(_zoomLevel); // Convert meters to pixels based on zoom

//   // Adjust the radius to ensure it doesn't scale too drastically
//   // Scaling factor is applied to prevent the circle from growing too large
//   double radiusInPixels = meters * pixelsPerMeter / 1000;  // Convert meters to pixels

//   // Optionally, adjust scaling factor based on zoom level to control maximum size
//   double maxRadiusInPixels = 1000; // Example: maximum circle size in pixels, adjustable
//   radiusInPixels = radiusInPixels < maxRadiusInPixels ? radiusInPixels : maxRadiusInPixels;

//   print("Calculated radius: $radiusInPixels pixels");

//   return radiusInPixels;
// }



//   double _metersToPixelsAtZoom(double zoomLevel) {
//     // Use floor or toInt to cast zoomLevel to an integer for bit shifting
//     int zoomInt = zoomLevel.toInt(); // Convert zoomLevel to an integer

//     const double earthCircumference = 40075017; // meters at the equator
//     double scale = earthCircumference /
//         (256 * (1 << zoomInt)); // Calculate scale in pixels per meter

//     return scale;
//   }
// }
