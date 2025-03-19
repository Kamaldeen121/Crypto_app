import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:main_crypto_app/models/coin_model.dart';
import 'package:main_crypto_app/services/coin_services.dart';
import 'package:provider/provider.dart';

class CoinController extends ChangeNotifier {
  CoinServices coinServices;
  CoinController({required this.coinServices});
  List<CoinModel> coinModelList = [];
  bool isloading = false;
  String responseMessage = '';

  Future<void> getCoins() async {
    isloading = true;

    final response = await coinServices.getCoins();
    if (response.statusCode == 200) {
      //print('fetching data${response.data}');
      coinModelList = (response.data as List)
          .map((coin) => CoinModel.fromJson(coin))
          .toList();
      isloading = false;
      notifyListeners();
    } else {
      responseMessage = 'Something went wrong';
      isloading = false;
      notifyListeners();
    }
  }
}
