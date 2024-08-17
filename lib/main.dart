import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip/screens/main_page_screen.dart';
import 'package:trip/screens/splash_screen.dart';
import 'package:trip/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // darkTheme: TAppTheme.darkTheme,
      theme: TAppTheme.lightTheme,
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) =>
            MainPageScreen(title: 'محاسبه سفرسازی کاربرهای شهر تهران'),
      },
      debugShowCheckedModeBanner: false,
      title: 'Trip Calculator',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      //       .copyWith(background: Colors.grey[100]),
      // ),
    );
  }
}
