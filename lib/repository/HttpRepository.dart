import 'package:exchange_app/model/Currency.dart';
import 'package:exchange_app/model/CustomError.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/apiKey.dart';

class HttpRepository {
  var logger = Logger();

  Future<List<CurrencyModel>> getCurrentCurrency() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> jsonResponse;

    const myApiKey = personalKey;

    var url = Uri.https('v6.exchangerate-api.com', '/v6/$myApiKey/latest/USD');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> mapOfCurrency = jsonResponse['conversion_rates'];

        List<CurrencyModel> listOfCurrency = mapOfCurrency.entries.map((e) => CurrencyModel.fromMap(e)).toList();

        //Save in shared preference
        final String encodedData = CurrencyModel.encode(listOfCurrency);
        await prefs.setString('currencyList', encodedData);

        return listOfCurrency;
      }
      throw 'Something went wrong';
    } catch (e) {
      throw CustomError(code: 'Exception', message: e.toString());
    }
  }
}
