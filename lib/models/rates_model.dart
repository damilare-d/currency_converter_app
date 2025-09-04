class RatesModel {
  final String baseCode;
  final Map<String, dynamic> rates;

  RatesModel({
    required this.baseCode,
    required this.rates,
  });

  factory RatesModel.fromJson(Map<String, dynamic> json) {
    return RatesModel(
      baseCode: json['base_code'],
      rates: Map<String, dynamic>.from(json['conversion_rates']),
    );
  }
}
