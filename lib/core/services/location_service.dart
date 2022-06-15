import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Position? currentLocation;
  double? latitude;
  double? longtitude;
  final Logger log = Logger();

  Future<Position?> getCurrentLocation() async {
    currentLocation = await Geolocator.getCurrentPosition();
    if (currentLocation == null) {
      await checkPermissionStatus();
      await checkGpsService();
    }
    log.d(
        'Latitude: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}');
  }

  checkPermissionStatus() async {
    LocationPermission permission = await checkPermissionStatus();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Permission.location.request();
    }
  }

  checkGpsService() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      Get.defaultDialog(
          title: 'GPS is Disabled',
          middleText: 'Please turn on your GPS Location',
          textConfirm: 'TURN ON',
          onConfirm: () async {
            await Geolocator.openLocationSettings();
            Get.back();
          },
          textCancel: 'Skip',
          onCancel: () {});
    }
  }

  static Future<String> getAddressFromLatLng(LatLng? location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          location!.latitude, location.longitude);

      Placemark place = placemarks[0];
      print("the location is  ${place.thoroughfare} " +
          " ${place.subLocality}" +
          " ${place.locality}" +
          " ${place.country}");
      return "${place.thoroughfare} ${place.subLocality} ${place.locality} ${place.country}";
    } catch (e) {
      print("the exception is $e");
      return '';
    }
  }
}
