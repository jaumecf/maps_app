import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/ui/ui.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.deepPurpleAccent,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            // TODO: cridar el controller del Bloc
            final userLocation = locationBloc.state.lastKnownLocation;
            //if (userLocation == null) return;
            //Tdodo: Snack...
            if (userLocation == null) {
              final customSnackBar =
                  CustomSnackBar(message: 'No hi ha ubicació');
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar);
              return;
            }

            mapBloc.moveCamera(userLocation);
          },
          icon: const Icon(Icons.my_location_outlined),
        ),
      ),
    );
  }
}
