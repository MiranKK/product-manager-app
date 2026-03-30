import 'package:clothes_store_app/provider/auth_provider.dart';
import 'package:clothes_store_app/screens/home_screen.dart';
import 'package:clothes_store_app/screens/login_screen.dart';
import 'package:clothes_store_app/screens/onboarding_screen.dart';
import 'package:clothes_store_app/screens/register_screen.dart';
import 'package:clothes_store_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (_) => AuthProvider(),)
],
child: const MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,

    builder: (_, child) => MaterialApp(
      title: 'Laza Store',
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/onboard": (context) => OnboardingScreen(),
        "/register": (context) => RegisterScreen(),
        "/login": (context) => LoginScreen(),
        "/home": (context) => HomeScreen(),
      },
    ));
  }
}
