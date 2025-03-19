import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_crypto_app/models/chart_model.dart';
import 'package:main_crypto_app/models/coin_model.dart';
import 'package:main_crypto_app/widgets/big_text.dart';
import 'package:main_crypto_app/widgets/small_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;

class SelectCoinPage extends StatefulWidget {
  final CoinModel coin; // Accept full CoinModel object

  const SelectCoinPage({super.key, required this.coin});

  @override
  State<SelectCoinPage> createState() => _SelectCoinPageState();
}

class _SelectCoinPageState extends State<SelectCoinPage> {
  late TrackballBehavior trackballBehavior;
  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  //List<String> days = ['D', 'W', 'M', '3M', '6M', 'Y'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Center(
      //     child: BigText(
      //       text: widget.coin.name.toString(), // Use dynamic coin name
      //       fontSize: 20,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10.r, right: 10.r),
            height: MediaQuery.sizeOf(context).height.h,
            width: MediaQuery.sizeOf(context).width.w,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      widget.coin.image
                          .toString(), // Display coin image dynamically
                      width: 70.w,
                      height: 70.h,
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: widget.coin.name.toString(), // Coin name
                          fontSize: 20.sp,
                        ),
                        SmallText(
                          text: widget.coin.symbol.toString(), // Coin symbol
                          fontSize: 15.sp,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(
                          text: '\$${widget.coin.currentPrice.toString()}',
                          fontSize: 15.sp,
                        ),
                        SmallText(
                          text:
                              '${widget.coin.priceChangePercentage24h?.toStringAsFixed(2)}%',
                          color: widget.coin.priceChangePercentage24h! > 0
                              ? Colors.green
                              : Colors.red,
                          fontSize: 13.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SmallText(text: 'Low', fontSize: 20.sp.sp),
                        SmallText(
                          text: '\$${widget.coin.low24h.toString()}',
                          fontSize: 15,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SmallText(text: 'High', fontSize: 20.sp),
                        SmallText(
                          text: '\$${widget.coin.high24h.toString()}',
                          fontSize: 15,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SmallText(text: 'Volume', fontSize: 20.sp),
                        SmallText(
                          text: widget.coin.totalVolume.toString(),
                          fontSize: 15.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                  height: 400.h,
                  width: double.infinity.w,
                  child: isRefresh == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xffFBC700),
                          ),
                        )
                      : SfCartesianChart(
                          trackballBehavior: trackballBehavior,
                          zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true, zoomMode: ZoomMode.x),
                          series: <CandleSeries>[
                            CandleSeries<ChartModel, int>(
                                enableSolidCandles: true,
                                enableTooltip: true,
                                bullColor: Colors.green,
                                bearColor: Colors.red,
                                dataSource: itemChart,
                                xValueMapper: (ChartModel sales, _) =>
                                    sales.time,
                                lowValueMapper: (ChartModel sales, _) =>
                                    sales.low,
                                highValueMapper: (ChartModel sales, _) =>
                                    sales.high,
                                openValueMapper: (ChartModel sales, _) =>
                                    sales.open,
                                closeValueMapper: (ChartModel sales, _) =>
                                    sales.close,
                                animationDuration: 55)
                          ],
                        ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 30.h,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35).r,
                    child: ListView.builder(
                        itemCount: text.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          //final selectDays = days[index];
                          //currentIndex = index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                textBool = [
                                  false,
                                  false,
                                  false,
                                  false,
                                  false,
                                  false
                                ];
                                textBool[index] = true;
                                setDays(text[index]);
                                getChart();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 5).r,
                              height: 50.h,
                              width: 50.w,
                              color: textBool[index] == true
                                  ? Color(0xffFBC700).withOpacity(0.3)
                                  : Colors.transparent,
                              child:
                                  Center(child: SmallText(text: text[index])),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BigText(
                        text: 'News',
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      width: 900.w,
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align items to the top
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 50.r),
                              child: SmallText(
                                text:
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                              ),
                            ),
                          ),
                          SizedBox(
                              width:
                                  10.w), // Add spacing between text and avatar
                          Padding(
                            padding: const EdgeInsets.only(right: 20).r,
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.red,
                              backgroundImage: AssetImage('images/11.PNG'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 40.h,
              width: 200.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.amber),
              child: Center(
                  child: BigText(
                text: '+ Add to portfolio',
                fontSize: 15.sp,
              )),
            ),
            Container(
              height: 40.h,
              width: 80.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50).r,
                  color: Colors.grey.shade200),
              child: Icon(Icons.notifications),
            )
          ],
        ),
      ),
    );
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, false, true, false, false, false];

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool isRefresh = true;

  Future<void> getChart() async {
    String url =
        'https://api.coingecko.com/api/v3/coins/${widget.coin.id}/ohlc?vs_currency=usd&days=${days.toString()}';

    setState(() {
      isRefresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
