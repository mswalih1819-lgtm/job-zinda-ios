import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:jora_customer/Settings/widgets/errorMsg.dart';
import 'package:jora_customer/main.dart';
import 'package:jora_customer/view_model/connect_page_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class LocationViewModel extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  double? latitude;
  double? longitude;

  List<Map<String, dynamic>> locationList = [];

  final String apiKey = 'AIzaSyBoACDW_61MW8Py611Sb7A9yfKwWqMZTTA';
  Future<List<Map<String, dynamic>>> getLocationSuggestions(
      String query) async {
    final encodedQuery = Uri.encodeComponent(query.trim());

    print("encoded-----$encodedQuery");
    // final String apiKey = 'AIzaSyAmULzzXZn7vEWNSgRQNbHYRRVGXef4QIU';
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedQuery&components=country:IN&types=geocode&key=$apiKey',
    );
    // final url =
    //     'https://nominatim.openstreetmap.org/search?q=$encodedQuery&format=json&limit=5&accept-language=en&countrycodes=IN';

    final response = await http.get(url);
    if (response.statusCode == 200) {
      locationList.clear();
      var data = json.decode(response.body);
      print("location response-----$data");
      final predictions = data['predictions'] as List;

      for (Map<String, dynamic> item in predictions) {
        locationList.add(item);
      }
      notifyListeners();
      return locationList;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  getPlaceDetails(
      String placeId, BuildContext context, String page, String place) async {
    EasyLoading.show();
    final detailsUrl = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey',
    );
    context.read<ProfileViewModel>().addressController.text = place;
    notifyListeners();
    try {
      final response =
          await http.get(detailsUrl).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = data['result'];

        if (result != null) {
          Map<String, dynamic> map = {
            "name": result['name'],
            "latitude": result['geometry']['location']['lat'],
            "longitude": result['geometry']['location']['lng'],
          };
          latitude = map["latitude"];
          longitude = map["longitude"];

          print("page-----$page");
          if (page == 'map') {
            navigatorKey.currentContext!
                .read<ConnectPageViewModel>()
                .updateLocation(latitude, longitude);
          } else {
            List<Placemark> placemarks = await placemarkFromCoordinates(
              map["latitude"],
              map["longitude"]!,
            );
            Placemark place = placemarks[0];

            navigatorKey.currentContext!.read<ProfileViewModel>().stateList = [
              place.administrativeArea!
            ];
            navigatorKey.currentContext!
                .read<ProfileViewModel>()
                .stateController
                .text = place.administrativeArea.toString();
            print("object---${place.subAdministrativeArea}");

            navigatorKey.currentContext!
                .read<ProfileViewModel>()
                .updateState(place.administrativeArea!);

            navigatorKey.currentContext!
                .read<ProfileViewModel>()
                .cityController
                .text = place.locality ?? "";
            navigatorKey.currentContext!
                .read<ProfileViewModel>()
                .zipCodeController
                .text = place.postalCode.toString();
            // }
          }

          notifyListeners();
          EasyLoading.dismiss();
          Navigator.pop(context);
        }
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }
    return null;
  }

  // updateLocation(
  //     {required String locationName,
  //     required String city,
  //     required String state,
  //     required BuildContext context}) {
  //   print("sttt-----$state--$city");
  //   context.read<ProfileViewModel>().addressController.text = locationName;
  //   context.read<ProfileViewModel>().cityController.text = city;
  //   context.read<ProfileViewModel>().selectedState = state;
  //   context.read<ProfileViewModel>().stateList = [state];

  //   notifyListeners();
  //   Navigator.pop(context);
  // }

  Future<void> checkLocation(BuildContext context) async {
    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        ErrorMsg.showSnakError(context, "Location services are disabled.");
      }
      LocationPermission permission = await Geolocator.checkPermission();
      print("location permmiss----$permission");
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          print("Location permissions are denied.");
          return; // Stop further execution
        }
      }

      // Get current position
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);
      // latitude = position.latitude;
      // longitude = position.longitude;

      // List<Placemark> placemarks =
      //     await placemarkFromCoordinates(position.latitude, position.longitude);

      // if (placemarks.isNotEmpty) {
      //   Placemark place = placemarks[0];
      //   stateList = [place.administrativeArea!];
      //   selectedState = place.administrativeArea!;
      //   cityController.text = place.locality!;
      // }
    } catch (e) {}
  }
}
