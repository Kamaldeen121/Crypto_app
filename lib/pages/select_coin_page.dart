import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_crypto_app/models/coin_model.dart';
import 'package:main_crypto_app/widgets/big_text.dart';
import 'package:main_crypto_app/widgets/small_text.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SelectCoinPage extends StatefulWidget {
  final CoinModel coin; // Accept full CoinModel object

  const SelectCoinPage({super.key, required this.coin});

  @override
  State<SelectCoinPage> createState() => _SelectCoinPageState();
}

class _SelectCoinPageState extends State<SelectCoinPage> {
  List<String> days = ['D', 'W', 'M', '3M', '6M', 'Y'];
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
                  width: double.maxFinite.w,
                  child: SfSparkLineChart(
                    trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap,
                    ),
                    marker: SparkChartMarker(
                      displayMode: SparkChartMarkerDisplayMode.low,
                    ),
                    labelDisplayMode: SparkChartLabelDisplayMode.high,
                    data: widget.coin.sparklineIn7d?.price ?? [],
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
                        itemCount: days.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final selectDays = days[index];
                          //currentIndex = index;
                          return GestureDetector(
                            onTap: () {
                              currentIndex = index;

                              setState(() {});
                              // print('tapped+${index}');
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 5).r,
                              height: 50.h,
                              width: 50.w,
                              color: currentIndex == index
                                  ? Colors.amber
                                  : Colors.white24,
                              child: Center(child: SmallText(text: selectDays)),
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
}
