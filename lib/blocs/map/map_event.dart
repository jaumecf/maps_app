part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);
}

class OnFollowingUser extends MapEvent {
  final bool isFollowingUser;
  const OnFollowingUser(this.isFollowingUser);
}

class UpdateUserPolylinesEvent extends MapEvent {
  final List<LatLng> userLocations;
  const UpdateUserPolylinesEvent(this.userLocations);
}

class OnToggleUserRoute extends MapEvent {}
