import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';


const String BASE_URL="https://apiv2.bitcoinaverage.com/indices/global/ticker/";

class NetworkHelper{

  Future<String> getBitcoinPriceData(String currency) async
  {
    print("get BTC price data called for $currency");
    http.Response response = await http.get(BASE_URL+"BTC$currency", headers: {"x-ba-key":API_KEY});
    if (response.statusCode == 200) {
      String data= response.body;
      String price= jsonDecode(data)["last"].toString();
      print("btc price= $price");
      return price;
    } else {
      print(response.statusCode);
      print(response.body);
      return "?";
    }
  }

  Future<String> getEtheriumPriceData(String currency) async
  {
    print("get ETH price data called for $currency");
    http.Response response = await http.get(BASE_URL+"ETH$currency", headers: {"x-ba-key":API_KEY});
    if (response.statusCode == 200) {
      String data= response.body;
      String price= jsonDecode(data)["last"].toString();
      print("eth price= $price");
      return price;
    } else {
      print(response.statusCode);
      print(response.body);
      return "?";
    }
  }

  Future<String> getLitecoinPriceData(String currency) async
  {
    print("get LTC price data called for $currency");
    http.Response response = await http.get(BASE_URL+"LTC$currency", headers: {"x-ba-key":API_KEY});
    if (response.statusCode == 200) {
      String data= response.body;
      String price= jsonDecode(data)["last"].toString();
      print("ltc price= $price");
      return price;
    } else {
      print(response.statusCode);
      print(response.body);
      return "?";
    }
  }
}
