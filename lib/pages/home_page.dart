import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_crypto_app/controllers/coin_controller.dart';
import 'package:main_crypto_app/pages/select_coin_page.dart';
import 'package:main_crypto_app/widgets/big_text.dart';
import 'package:main_crypto_app/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:sparkline/sparkline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool obsecureText = true;
  bool showBalance = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CoinController>(context, listen: false).getCoins();
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = ScreenUtil().screenWidth;
    // double screenHeight = ScreenUtil().screenHeight;

    // print('Screen Width: $screenWidth');
    // print('Screen Height: $screenHeight');
    final coinController = Provider.of<CoinController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30.r, left: 20.r, right: 20.r),
                height: MediaQuery.sizeOf(context).height.h,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.9),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.r, vertical: 5.r),
                          decoration: BoxDecoration(color: Colors.white54),
                          child: BigText(
                            text: 'Main portfolio',
                            fontSize: 15,
                          ),
                        ),
                        BigText(
                          text: 'Top 10 coins',
                          fontSize: 15.sp,
                        ),
                        BigText(
                          text: 'Experimental',
                          fontSize: 15.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                showBalance
                                    ? BigText(text: '\$7,466.20')
                                    : BigText(text: '******'),
                                IconButton(
                                  icon: Icon(showBalance
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      showBalance = !showBalance;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white54,
                          child: Image.asset(
                            'images/5.1.png',
                            height: 30.h,
                            width: 30.w,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BigText(
                          text: '+162% all time',
                          fontSize: 15.sp,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0.r,
                top: 200.r,
                left: 0.r,
                right: 0.r,
                child: Container(
                  padding: EdgeInsets.only(top: 30.r, left: 20.r, right: 10.r),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.r),
                          topRight: Radius.circular(50.r))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: 'Assets',
                            fontSize: 20.sp,
                          ),
                          Icon(Icons.add),
                        ],
                      ),
                      SizedBox(
                        height: 350.h,
                        child: coinController.isloading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                //physics: NeverScrollableScrollPhysics(),
                                itemCount: coinController.coinModelList.length,
                                itemBuilder: (context, index) {
                                  final coinType =
                                      coinController.coinModelList[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            coinType.image.toString(),
                                            height: 50.h,
                                            width: 50.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 70.w,
                                                child: BigText(
                                                  maxLines: 1,
                                                  text:
                                                      coinType.name.toString(),
                                                  fontSize: 20.sp,
                                                ),
                                              ),
                                              SmallText(text: '0.4 usdt')
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 60.h,
                                        width: 100.w,
                                        child: Sparkline(
                                          fallbackHeight: 20.h,
                                          data: coinType.sparklineIn7d?.price ??
                                              [],
                                          lineColor: Colors.blue,
                                          fillMode: FillMode.below,
                                          fillGradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.blue.withOpacity(0.5),
                                              Colors.transparent
                                            ],
                                          ),
                                          pointsMode: PointsMode.all,
                                          pointSize: 1.0,
                                          pointColor:
                                              Colors.red, // Highlight points
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          BigText(
                                            text: coinType.currentPrice
                                                .toString(),
                                            fontSize: 20.sp,
                                          ),
                                          Row(
                                            children: [
                                              SmallText(text: '\$67.8'),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              SmallText(
                                                text: '0.44%',
                                                color: Colors.green,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BigText(
                        text: 'Recommended to Buy',
                        fontSize: 20.sp,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 140.h,
                        child: coinController.isloading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                            : ListView.builder(
                                itemCount: coinController.coinModelList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final recommendedCoin =
                                      coinController.coinModelList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectCoinPage(
                                                    coin: recommendedCoin,
                                                  )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20.r),
                                      padding: EdgeInsets.all(10.r),
                                      height: 50.h,
                                      width: 140.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(20.r)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            recommendedCoin.image.toString(),
                                            height: 50.h,
                                            width: 50.h,
                                          ),
                                          BigText(
                                            text: recommendedCoin.id.toString(),
                                            fontSize: 15.sp,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SmallText(
                                                  text: recommendedCoin.symbol
                                                      .toString()),
                                              SmallText(
                                                text: recommendedCoin.low24h
                                                    .toString(),
                                                color: Colors.green,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
