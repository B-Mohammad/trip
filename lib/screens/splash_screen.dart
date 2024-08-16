import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:trip/controller/main_page_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainPageController controller;
    controller = Get.put(MainPageController());
    controller.getListFormModels();
    // زمان انتظار برای نمایش صفحه اسپلش
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
    return Scaffold(
      backgroundColor: Colors.blue, // رنگ پس‌زمینه صفحه اسپلش
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/tehran_uni.png"),
            const SizedBox(height: 20.0),
            const Text(
              " محاسبه سفرسازی کاربرهای شهر تهران",
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
