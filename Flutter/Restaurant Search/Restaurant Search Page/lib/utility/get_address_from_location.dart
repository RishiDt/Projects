import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'get_location.dart';

Future<String> getAddress({double? latitude, double? longitude}) async {
  if (latitude == null && longitude == null) {
    Position? loc = await getLocation();
    if (loc != null) {
      latitude = loc.latitude;
      longitude = loc.longitude;
    } else {
      return "No location";
    }
  }

  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude!, longitude!);
  Placemark place = placemarks[0];
  return "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
}
