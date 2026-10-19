import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_colors.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_cubit.dart';
import 'features/admin/presentation/cubit/admin_cubit.dart';
import 'features/appointments/presentation/cubit/appointments_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/doctors/presentation/cubit/doctors_cubit.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rlvqvbhcixcpfxexkhie.supabase.co',
    publishableKey: 'sb_publishable_sw9XXUV-mG80OMgi-bn-Cw_VE09glsu',
  );

  runApp(const DoctorHuntApp());
}

class DoctorHuntApp extends StatelessWidget {
  const DoctorHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<DoctorsCubit>(create: (_) => DoctorsCubit()),
        BlocProvider<AppointmentsCubit>(create: (_) => AppointmentsCubit()),
        BlocProvider<AdminCubit>(create: (_) => AdminCubit()),
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, currentLocale) {
          return MaterialApp(
            title: 'Doctor Hunt',
            debugShowCheckedModeBanner: false,
            locale: currentLocale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: currentLocale.languageCode == 'ar' ? null : null,
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}