import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'apps/features/auth/presentation/screens/splash/splash_screen.dart';
import 'apps/generated/app_colore.dart';
import 'apps/features/auth/presentation/controller/auth_bloc.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 
  await Supabase.initialize(
    url: 'https://rlvqvbhcixcpfxexkhie.supabase.co',
    anonKey: 'sb_publishable_sw9XXUV-mG80OMgi-bn-Cw_VE09glsu',
  );

  runApp(const DoctorHuntApp());
}

class DoctorHuntApp extends StatelessWidget {
  const DoctorHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(),
      child: MaterialApp(
      title: 'Doctor Hunt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      ));
    
  }
}