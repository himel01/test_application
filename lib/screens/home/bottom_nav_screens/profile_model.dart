import 'dart:convert';

class ProfileModel {
  final String? address;
  final double? balance;
  final String? city;
  final String? country;
  final int? currency;
  final int? currentTradesCount;
  final double? currentTradesVolume;
  final double? equity;
  final double? freeMargin;
  final bool? isAnyOpenTrades;
  final bool? isSwapFree;
  final int? leverage;
  final String? name;
  final String? phone;
  final int? totalTradesCount;
  final double? totalTradesVolume;
  final int? type;
  final int? verificationLevel;
  final String? zipCode;

  ProfileModel({
    this.address,
    this.balance,
    this.city,
    this.country,
    this.currency,
    this.currentTradesCount,
    this.currentTradesVolume,
    this.equity,
    this.freeMargin,
    this.isAnyOpenTrades,
    this.isSwapFree,
    this.leverage,
    this.name,
    this.phone,
    this.totalTradesCount,
    this.totalTradesVolume,
    this.type,
    this.verificationLevel,
    this.zipCode,
  });

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        address: json["address"],
        balance: json["balance"]?.toDouble(),
        city: json["city"],
        country: json["country"],
        currency: json["currency"],
        currentTradesCount: json["currentTradesCount"],
        currentTradesVolume: json["currentTradesVolume"]?.toDouble(),
        equity: json["equity"]?.toDouble(),
        freeMargin: json["freeMargin"]?.toDouble(),
        isAnyOpenTrades: json["isAnyOpenTrades"],
        isSwapFree: json["isSwapFree"],
        leverage: json["leverage"],
        name: json["name"],
        phone: json["phone"],
        totalTradesCount: json["totalTradesCount"],
        totalTradesVolume: json["totalTradesVolume"]?.toDouble(),
        type: json["type"],
        verificationLevel: json["verificationLevel"],
        zipCode: json["zipCode"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "balance": balance,
        "city": city,
        "country": country,
        "currency": currency,
        "currentTradesCount": currentTradesCount,
        "currentTradesVolume": currentTradesVolume,
        "equity": equity,
        "freeMargin": freeMargin,
        "isAnyOpenTrades": isAnyOpenTrades,
        "isSwapFree": isSwapFree,
        "leverage": leverage,
        "name": name,
        "phone": phone,
        "totalTradesCount": totalTradesCount,
        "totalTradesVolume": totalTradesVolume,
        "type": type,
        "verificationLevel": verificationLevel,
        "zipCode": zipCode,
      };
}
