part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  // Definint les Polylines, les polylines les utilitzarem al Map View
  final Map<String, Polyline> polylines;
  /* Estructura desitjada
  'ruta' : {
    id: polylineID Google,
    points: [[lat,long],[1234,5678],...]
    width: 3,
    color: black87
  },
  'desti' : {
    id: polylineID Google,
    points: [[lat,long],[1234,5678],...]
    width: 3,
    color: black87
  }, etc...
  */

  const MapState(
      {this.isMapInitialized = false,
      this.isFollowingUser = true,
      this.showMyRoute = true,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {};

  MapState copyWith(
          {bool? isMapInitialized,
          bool? followUser,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
          isMapInitialized: isMapInitialized ?? this.isMapInitialized,
          isFollowingUser: followUser ?? this.isFollowingUser,
          polylines: polylines ?? this.polylines,
          showMyRoute: showMyRoute ?? this.showMyRoute);

  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, polylines, showMyRoute];
}
