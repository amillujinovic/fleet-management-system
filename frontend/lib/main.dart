import 'package:fleet_management_app/blocs/obd/obd_bloc.dart';
import 'package:fleet_management_app/blocs/vehicles/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'screens/login_screen.dart';
import 'blocs/vehicles/vehicles_bloc.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider<AuthBlock>(
          create: (context) => AuthBlock(),
         ),
        BlocProvider<VehiclesBloc>(create: (context) =>VehiclesBloc(),),
        BlocProvider<ObdBloc>(create: (_) => ObdBloc()),
      ],
     child: MaterialApp(
        title: 'Fleet Management System',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1A3B5D),
          ),
        ),
        home:  LoginScreen(),  
      ),
    );
    
}
}