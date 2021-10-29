import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  GoogleMapController? _googleMapController;

  Position? _position;

  Marker? marker;
  Circle? circle;

  Placemark? placemark;

  Future<Position?> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return _position;
  }

  _getLocationAddress(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    placemark = placemarks[0];
    print('placemarks ${placemarks[0]}');
    print('placemarks ${placemark!.subAdministrativeArea}');
    // print();
    return placemarks;
  }

  void updateMarkerAndCircle(Position newLocation) {
    LatLng latLngPos = LatLng(newLocation.latitude, newLocation.longitude);
    this.setState(() {
      marker = Marker(
        markerId: MarkerId('id'),
        position: latLngPos,
        draggable: false,
        zIndex: 2,
        flat: true,
        rotation: newLocation.heading,
        anchor: Offset(0.5, 0.5),
        infoWindow: InfoWindow(
          snippet: '${placemark!.subAdministrativeArea}',
          title: (placemark != null ? 'Address ' : 'fghfghfgh'),
        ),
      );

      circle = Circle(
        circleId: CircleId('circle'),
        radius: newLocation.accuracy,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLngPos,
        fillColor: Colors.blue.withAlpha(70),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _getLocation().then((value) {
            print(value);
            var latlngposition = LatLng(value!.latitude, value.longitude);
            CameraPosition cameraPosition =
                CameraPosition(target: latlngposition, zoom: 18);
            _googleMapController!
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            _getLocationAddress(value);
            updateMarkerAndCircle(value);
          });
        },
        child: (Icon(Icons.location_searching)),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.0444, 31.2357),
          zoom: 15,
        ),
        mapType: MapType.satellite,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _googleMapController = controller;
          });
        },
        markers: Set.of((marker != null) ? [marker!] : []),
        circles: Set.of((circle != null) ? [circle!] : []),
      ),
    );
  }
}
