import 'dart:convert';
import 'package:http/http.dart' as http;

class MlApiService {
  static const baseUrl = String.fromEnvironment('AGRISMART_ML_BASE_URL', defaultValue: 'http://10.0.2.2:8000');

  static Future<Map<String,dynamic>> _post(String path, Map<String,dynamic> body) async {
    final r = await http.post(Uri.parse('$baseUrl$path'), headers: const {'Content-Type':'application/json'}, body: jsonEncode(body)).timeout(const Duration(seconds:20));
    Map<String,dynamic> data;
    try { data = jsonDecode(r.body) as Map<String,dynamic>; } catch (_) { throw Exception('ML service returned invalid JSON.'); }
    if (r.statusCode < 200 || r.statusCode >= 300) throw Exception((data['detail'] ?? data['error'] ?? 'ML request failed').toString());
    return data;
  }

  static Future<Map<String,dynamic>> fertilizer({required double temperature,required double humidity,required double moisture,required String soilType,required String cropType,required double nitrogen,required double potassium,required double phosphorous}) =>
    _post('/api/v1/fertilizer-recommendation', {'temperature':temperature,'humidity':humidity,'moisture':moisture,'soil_type':soilType,'crop_type':cropType,'nitrogen':nitrogen,'potassium':potassium,'phosphorous':phosphorous});

  static Future<Map<String,dynamic>> yieldPrediction({required String crop,required int cropYear,required String season,required String state,required double area,required double annualRainfall,required double fertilizer,required double pesticide}) =>
    _post('/api/v1/yield-prediction', {'crop':crop,'crop_year':cropYear,'season':season,'state':state,'area':area,'annual_rainfall':annualRainfall,'fertilizer':fertilizer,'pesticide':pesticide});

  static Future<Map<String,dynamic>> pestRisk({required String crop,required String pest,required double temperatureC,required double humidityPct,required double rainfallMm,required double soilMoisturePct,required double pestCount,required double etl}) =>
    _post('/api/v1/pest-risk', {'crop':crop,'pest':pest,'temperature_c':temperatureC,'humidity_pct':humidityPct,'rainfall_mm':rainfallMm,'soil_moisture_pct':soilMoisturePct,'pest_count':pestCount,'etl':etl});
}
