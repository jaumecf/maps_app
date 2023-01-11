part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;

  const MapState({this.isMapInitialized = false, this.isFollowingUser = true});

  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: followUser ?? this.isFollowingUser,
      );

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser];
}
