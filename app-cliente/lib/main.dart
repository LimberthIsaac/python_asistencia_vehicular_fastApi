import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/permission_page.dart';
import 'pages/request_assistance_page.dart';
import 'pages/tracking_page.dart';
import 'pages/rating_page.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'AsistAuto',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/permissions': (context) => const PermissionPage(),
          '/request': (context) => const RequestAssistancePage(),
          '/tracking': (context) => const TrackingPage(),
          '/rating': (context) => const RatingPage(),
        },
      ),
    );
  }
}
