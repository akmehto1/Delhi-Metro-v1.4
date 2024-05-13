import 'package:geolocator/geolocator.dart';
class LocationService {
  Future<Position> getLocation() async {
    try {
      // Request permission to access location
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle the case where the user denies access to location
        return Future.error('Location permission denied');
      }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {

      return Future.error('Error getting location: $e');
    }
  }
}


