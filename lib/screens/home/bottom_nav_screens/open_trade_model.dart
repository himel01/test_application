import 'dart:convert';

List<OpenTradeModel> openTradeModelFromJson(String str) => List<OpenTradeModel>.from(
    json.decode(str).map((x) => OpenTradeModel.fromJson(x)));

class OpenTradeModel {
  final double? currentPrice;
  final dynamic comment;
  final int? digits;
  final int? login;
  final double? openPrice;
  final DateTime? openTime;
  final double? profit;
  final double? sl;
  final double? swaps;
  final String? symbol;
  final double? tp;
  final int? ticket;
  final int? type;
  final double? volume;

  OpenTradeModel({
    this.currentPrice,
    this.comment,
    this.digits,
    this.login,
    this.openPrice,
    this.openTime,
    this.profit,
    this.sl,
    this.swaps,
    this.symbol,
    this.tp,
    this.ticket,
    this.type,
    this.volume,
  });

  factory OpenTradeModel.fromRawJson(String str) => OpenTradeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OpenTradeModel.fromJson(Map<String, dynamic> json) => OpenTradeModel(
    currentPrice: json["currentPrice"]?.toDouble(),
    comment: json["comment"],
    digits: json["digits"],
    login: json["login"],
    openPrice: json["openPrice"]?.toDouble(),
    openTime: json["openTime"] == null ? null : DateTime.parse(json["openTime"]),
    profit: json["profit"]?.toDouble(),
    sl: json["sl"]?.toDouble(),
    swaps: json["swaps"]?.toDouble(),
    symbol: json["symbol"],
    tp: json["tp"],
    ticket: json["ticket"],
    type: json["type"],
    volume: json["volume"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "currentPrice": currentPrice,
    "comment": comment,
    "digits": digits,
    "login": login,
    "openPrice": openPrice,
    "openTime": openTime?.toIso8601String(),
    "profit": profit,
    "sl": sl,
    "swaps": swaps,
    "symbol": symbol,
    "tp": tp,
    "ticket": ticket,
    "type": type,
    "volume": volume,
  };
}
