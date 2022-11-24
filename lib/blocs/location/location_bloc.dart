import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: true)));
    on<OnStopFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
          lastKnownLocation: event.newLocation,
          myLocationHistory: [...state.myLocationHistory, event.newLocation]));
    });
  }

  Future getCurrentPosition() async {
    final currentPosition = await Geolocator.getCurrentPosition();
    print('Position: $currentPosition');
    // Retornar un objecte de tipus LatLong de Google Maps
    return currentPosition;
  }

  void startFollowingUser() {
    print('Start following user');
    add(OnStartFollowingUser());
    positionStream = Geolocator.getPositionStream().listen(
      (event) {
        final position = event;
        add(OnNewUserLocationEvent(
            LatLng(position.latitude, position.longitude)));
        //print(event);
      },
    );
  }

  void stopFollowingUser() {
    print('Stop following user');
    add(OnStopFollowingUser());
    positionStream?.cancel();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    stopFollowingUser();
    return super.close();
  }
}
