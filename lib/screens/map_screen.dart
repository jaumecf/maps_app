import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/views/views.dart';

import '../widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.lastKnownLocation == null)
            return const Center(child: Text('Carregant les dades...'));

          // Envoltam el Stack amb el SingleChildScrollView per evitar que el
          // search Delegate, obri el teclat i ens molesti a la pantalla
          return SingleChildScrollView(
            // Recordem que l'ordre en que es col·loquen els Widgets a Stack,
            // és que els primers, estaran més al fons.
            child: Stack(
              children: [
                MapView(initialLocation: state.lastKnownLocation!),
                // Altres Widgets...
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnCurrentLocation(),
          BtnFollowUser(),
        ],
      ),
    );
  }
}
