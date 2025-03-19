import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_crypto_app/pages/bottom_nav.dart';
import 'package:main_crypto_app/pages/home_page.dart';
import 'package:main_crypto_app/widgets/big_text.dart';
import 'package:main_crypto_app/widgets/small_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('images/1.gif'),
              Column(
                children: [
                  BigText(
                    text: 'The Future',
                  ),
                  SizedBox(
                    width: 250.w,
                    child: SmallText(
                      text:
                          'Learn more about cryptocurrency, look to the future in IO Crypto',
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNav()));
                },
                child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.r, horizontal: 50.r),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.r, horizontal: 70.r),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      children: [
                        SmallText(text: 'CREATE PORTFOLIO'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.arrow_forward_sharp)
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
