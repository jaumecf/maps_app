import 'blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:maps_app/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      // Map Bloc té una dependència de LocationBloc
      BlocProvider(
          create: ((context) =>
              MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingScreen());
  }
}
