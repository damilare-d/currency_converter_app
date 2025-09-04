class ConversionModel {
  final String baseCode;
  final String targetCode;
  final double rate;

  ConversionModel({
    required this.baseCode,
    required this.targetCode,
    required this.rate,
  });

  factory ConversionModel.fromJson(Map<String, dynamic> json) {
    return ConversionModel(
      baseCode: json['base_code'],
      targetCode: json['target_code'],
      rate: (json['conversion_rate'] as num).toDouble(),
    );
  }
}
