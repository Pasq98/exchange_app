import 'dart:convert';

class CurrencyModel {
  String title;
  num value;

  CurrencyModel({required this.value, required this.title});

  CurrencyModel.fromMap(MapEntry<String, dynamic> item)
      : title = item.key,
        value = item.value;

  static Map<String, dynamic> toMap(CurrencyModel currency) => {'title': currency.title, 'value': currency.value};

  static String encode(List<CurrencyModel> currency) => json.encode(
        currency.map<Map<String, dynamic>>((currency) => CurrencyModel.toMap(currency)).toList(),
      );

  @override
  String toString() {
    return 'title: $title, value: $value';
  }
}
