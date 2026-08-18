import '../models/agri_models.dart';

class MockData {
  static final crops = [
    Crop(name: 'Wheat', type: 'Grain', soil: 'Loamy', irrigation: 'Drip', health: 'Excellent', growth: 78, planted: '12 Jun 2026', harvest: '20 Sep 2026'),
    Crop(name: 'Tomato', type: 'Vegetable', soil: 'Sandy Loam', irrigation: 'Drip', health: 'Good', growth: 62, planted: '28 Jun 2026', harvest: '10 Sep 2026'),
    Crop(name: 'Cotton', type: 'Fiber', soil: 'Black Soil', irrigation: 'Sprinkler', health: 'Needs attention', growth: 44, planted: '02 Jul 2026', harvest: '15 Nov 2026'),
  ];
  static final markets = [
    MarketItem(crop: 'Wheat', market: 'Ahmedabad APMC', unit: '₹/quintal', price: 2480, previous: 2390),
    MarketItem(crop: 'Tomato', market: 'Rajkot APMC', unit: '₹/kg', price: 42, previous: 38),
    MarketItem(crop: 'Cotton', market: 'Vadodara APMC', unit: '₹/quintal', price: 7160, previous: 7280),
    MarketItem(crop: 'Potato', market: 'Ahmedabad APMC', unit: '₹/kg', price: 31, previous: 29),
  ];
  static final farms = [
    Farm(name: 'Green Valley Farm', location: 'Sanand, Gujarat', soil: 'Loamy', irrigation: 'Drip', size: 8.5),
    Farm(name: 'Sunrise Field', location: 'Dholka, Gujarat', soil: 'Black Soil', irrigation: 'Sprinkler', size: 5.2),
  ];
}
