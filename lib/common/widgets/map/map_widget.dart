import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/location_util.dart';
import '../buttons.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key,
    this.controller,
    this.cameraInitPosition,
    this.markers,
    this.enableLocationButton = true,
    this.allowScroll = true,
    this.onCameraMove,
    this.onTap,
    this.onCameraIdle,
    this.polyLines,
    this.onMapCompleted,
  });

  final LatLng? cameraInitPosition;
  final Completer<GoogleMapController>? controller;
  final Set<Marker>? markers;
  final bool enableLocationButton;
  final bool allowScroll;
  final Function(CameraPosition)? onCameraMove;
  final Function(LatLng)? onTap;
  final Function()? onCameraIdle;
  final Map<PolylineId, Polyline>? polyLines;
  final VoidCallback? onMapCompleted;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  bool _mapLoading = true;
  bool _permission = false;
  Completer<GoogleMapController>? _controller;
  CameraPosition? _currentPosition;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? Completer();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    Position? locationData = await LocationUtil.instance.getCurrentLocation();
    if (locationData != null) {
      _currentPosition = CameraPosition(
        target: LatLng(
          locationData.latitude,
          locationData.longitude,
        ),
        zoom: 16,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_currentPosition != null)
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _currentPosition ??
                const CameraPosition(
                  target: LatLng(10.798951, 106.648815),
                  zoom: 16,
                ),
            scrollGesturesEnabled: widget.allowScroll,
            onMapCreated: (GoogleMapController controller) async {
              if (_controller != null && _controller?.isCompleted == false) {
                _controller?.complete(controller);
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (widget.onMapCompleted != null) {
                    widget.onMapCompleted!();
                  }
                  setState(() {
                    _mapLoading = false;
                  });
                });
              }
            },
            markers: widget.markers ?? <Marker>{},
            polylines: Set<Polyline>.of(widget.polyLines?.values ?? []),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onCameraMove: widget.onCameraMove,
            onTap: widget.onTap,
            onCameraIdle: widget.onCameraIdle,
          ),
        if (_mapLoading)
          Container(
            height: screenSize.width,
            width: screenSize.height,
            color: Colors.grey[100],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        if (widget.enableLocationButton)
          Positioned(
            bottom: 270,
            right: 20,
            child: SplashButton(
              borderRadius: const BorderRadius.all(Radius.circular(22)),
              onTap: _goCurrentLocation,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.my_location,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          )
      ],
    );
  }

  void _goCurrentLocation() async {
    if (!_permission) {
      _permission = await LocationUtil.instance.requestPermission(
        context: context,
        openSettings: true,
      );
      if (!_permission) {
        return;
      }
    }
    Position? locationData = await LocationUtil.instance.getCurrentLocation();

    if (locationData != null) {
      final GoogleMapController controller = await _controller!.future;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              locationData.latitude,
              locationData.longitude,
            ),
            zoom: 15,
          ),
        ),
      );
    }
  }
}
