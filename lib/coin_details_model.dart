// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CoinDetailsModel {
  String id;
  String symbol;
  String name;
  String image;
  num currentPrice;
  double priceChangePercentage24h;
  CoinDetailsModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  CoinDetailsModel copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    num? currentPrice,
    double? priceChangePercentage24h,
  }) {
    return CoinDetailsModel(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'currentPrice': currentPrice,
      'priceChangePercentage24h': priceChangePercentage24h,
    };
  }

  factory CoinDetailsModel.fromMap(Map<String, dynamic> map) {
    return CoinDetailsModel(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      currentPrice: map['current_price'] as num,
      priceChangePercentage24h: map['price_change_percentage_24h'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinDetailsModel.fromJson(String source) =>
      CoinDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CoinDetailsModel(id: $id, symbol: $symbol, name: $name, image: $image, currentPrice: $currentPrice, priceChangePercentage24h: $priceChangePercentage24h)';
  }

  @override
  bool operator ==(covariant CoinDetailsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.symbol == symbol &&
        other.name == name &&
        other.image == image &&
        other.currentPrice == currentPrice &&
        other.priceChangePercentage24h == priceChangePercentage24h;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        symbol.hashCode ^
        name.hashCode ^
        image.hashCode ^
        currentPrice.hashCode ^
        priceChangePercentage24h.hashCode;
  }
}
