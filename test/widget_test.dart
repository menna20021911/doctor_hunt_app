import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/apps/features/auth/presentation/screens/onboarding/onboarding1_screen.dart';
import 'package:flutter_application_1/apps/features/auth/presentation/screens/splash/splash_screen.dart';

void main() {
  Widget buildTestApp(Widget screen) => MaterialApp(home: screen);

  testWidgets('opens the first onboarding page after three seconds', (tester) async {
    await tester.pumpWidget(buildTestApp(const SplashScreen()));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Find Trusted Doctors'), findsOneWidget);
  });

  testWidgets('navigates through the onboarding pages with Next and Skip', (tester) async {
    await tester.pumpWidget(buildTestApp(const Onboarding1Screen()));

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Choose Best Doctors'), findsOneWidget);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Easy Appointments'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Choose your role'), findsOneWidget);
    expect(find.text('Patient'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Find Your Doctor'), findsOneWidget);
  });
}
