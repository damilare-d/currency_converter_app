class CodesModel {
  final List<List<String>> supportedCodes;

  CodesModel({required this.supportedCodes});

  factory CodesModel.fromJson(Map<String, dynamic> json) {
    return CodesModel(
      supportedCodes: List<List<String>>.from(
        json['supported_codes'].map((e) => List<String>.from(e)),
      ),
    );
  }
}
