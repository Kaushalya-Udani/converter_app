

import 'dart:convert';

CurrenciesResponse currenciesResponseFromJson(String str) => CurrenciesResponse.fromJson(json.decode(str));

String currenciesResponseToJson(CurrenciesResponse data) => json.encode(data.toJson());

class CurrenciesResponse {
  final Map<String, double>? data;

  CurrenciesResponse({
    this.data,
  });

  factory CurrenciesResponse.fromJson(Map<String, dynamic> json) => CurrenciesResponse(
    data: Map.from(json["data"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
