import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:main_crypto_app/api%20Client/api_client.dart';
import 'package:main_crypto_app/controllers/coin_controller.dart';
import 'package:main_crypto_app/pages/home_page.dart';
import 'package:main_crypto_app/pages/select_coin_page.dart';
import 'package:main_crypto_app/pages/splash_screen.dart';
import 'package:main_crypto_app/services/coin_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) =>
              CoinController(coinServices: CoinServices(ApiClient())))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 914),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
