import '../core/base_api.dart';
import '../models/code_model.dart';
import '../models/conversion_model.dart';
import '../models/rates_model.dart';

class ExchangeService {
  final BaseApi _api = BaseApi();

  Future<RatesModel> getLatestRates(String baseCode) async {
    final data = await _api.get("latest/$baseCode");
    return RatesModel.fromJson(data);
  }

  Future<ConversionModel> getConversion(String from, String to) async {
    final data = await _api.get("pair/$from/$to");
    return ConversionModel.fromJson(data);
  }

  Future<CodesModel> getSupportedCodes() async {
    final data = await _api.get("codes");
    return CodesModel.fromJson(data);
  }
}
