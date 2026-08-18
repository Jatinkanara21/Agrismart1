import 'package:flutter/foundation.dart';
import '../models/agri_models.dart';
import '../services/mock_data.dart';

class AppProvider extends ChangeNotifier {
  List<Crop> crops = [...MockData.crops];
  List<Farm> farms = [...MockData.farms];
  bool loading = false;

  Future<void> refresh() async {
    loading = true; notifyListeners();
    await Future.delayed(const Duration(milliseconds: 650));
    loading = false; notifyListeners();
  }

  void addCrop(Crop crop) { crops.add(crop); notifyListeners(); }
  void deleteCrop(Crop crop) { crops.remove(crop); notifyListeners(); }
}
