/// Backend-ready interfaces. Replace MockData calls with Firebase/API implementations later.
abstract class AuthService { Future<void> signIn(String email,String password); Future<void> register(String name,String email,String password); Future<void> resetPassword(String email); Future<void> signOut(); }
abstract class WeatherService { Future<Map<String,dynamic>> currentWeather(double lat,double lng); Future<List<Map<String,dynamic>>> forecast(double lat,double lng); }
abstract class DiseaseService { Future<Map<String,dynamic>> analyze(List<int> imageBytes); }
abstract class MarketService { Future<List<Map<String,dynamic>>> prices({String? crop,String? market}); }
abstract class FarmService { Future<List<Map<String,dynamic>>> farms(); Future<void> saveFarm(Map<String,dynamic> farm); }
