import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/themes.dart';

import '../blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<MapEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnMapInitializedEvent>(_onInitMap);
    on<OnFollowingUser>(_onFollowingUser);

    locationBloc.stream.listen((locationState) {
      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onFollowingUser(OnFollowingUser event, Emitter<MapState> emit) {
    emit(state.copyWith(followUser: event.isFollowingUser));
    if (!event.isFollowingUser || locationBloc.state.lastKnownLocation == null)
      return;
    // Optimització per no haver d'esperar noves coordenades per actualitzar
    // la posició, va directament, a la darrera posició que es sabia.
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }
}
