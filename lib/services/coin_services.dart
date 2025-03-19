import 'package:dio/dio.dart';
import 'package:main_crypto_app/api%20Client/api_client.dart';

class CoinServices {
  final ApiClient apiClient;
  CoinServices(this.apiClient);

  Future<Response> getCoins() async {
    final Response response = await apiClient
        .getData('/coins/markets?vs_currency=usd&sparkline=true');
    return response;
  }
}
