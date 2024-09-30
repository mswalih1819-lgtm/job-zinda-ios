import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:latlong2/latlong.dart';

class SimpleMap extends StatelessWidget {
  LatLng _center =
      const LatLng(28.7041, 77.1025); // San Francisco coordinates as an example
  double _radius = 10000; // default radius in meters
  List<LatLng> _photographers = [
    LatLng(28.7041, 77.1025), // Sample photographer locations
    LatLng(19.0760, 72.8777),
    // LatLng(19.1234, 72.1234),
    // LatLng(19.0760, 72.8777),
    // LatLng(19.0760, 72.8777),
    // LatLng(19.0760, 72.8777),

    // LatLng(37.7699, -122.4394),
  ];
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          initialCenter:
              LatLng(28.7041, 77.1025), // Updated parameter for initial center
          initialZoom: 3 // Updated parameter for initial zoom
          ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          // urlTemplate: "https://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png",
          userAgentPackageName: "com.example.app",
          subdomains: ['a', 'b', 'c'],
          // attributionBuilder: (_) {
          //   return Text("© OpenStreetMap contributors");
          // },
        ),
        CircleLayer(
          circles: [
            CircleMarker(
                point: _center,
                radius: 170, // Radius in meters
                color: Colors.grey.withOpacity(0.1),
                borderStrokeWidth: 2,
                borderColor: Colors.grey),
          ],
        ),
        MarkerLayer(
            markers: _photographers
                .map(
                  (e) => Marker(
                      width: 60,
                      height: 60,
                      point: e,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            const Color.fromARGB(255, 153, 220, 229),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: PColors.black,
                          backgroundImage: AssetImage(PImages.pro_pic3),
                        ),
                      )
                      // child: CircleAvatar(
                      //     radius: 25,
                      //     backgroundColor: Colors.blue,
                      //     child: CircleAvatar(
                      //       radius: 20,
                      //       backgroundImage: AssetImage(PImages.pro_pic3),
                      //     )),

                      ),
                )
                .toList()),
        MarkerLayer(markers: [
          Marker(
              point: LatLng(12.9716, 77.5946), // Location for the marker
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
    );
  }
}
