class Crop {
  final String name, type, soil, irrigation, health;
  final int growth;
  final String planted, harvest;
  Crop({required this.name, required this.type, required this.soil, required this.irrigation, required this.health, required this.growth, required this.planted, required this.harvest});
}

class MarketItem {
  final String crop, market, unit;
  final double price, previous;
  MarketItem({required this.crop, required this.market, required this.unit, required this.price, required this.previous});
}

class Farm {
  final String name, location, soil, irrigation;
  final double size;
  Farm({required this.name, required this.location, required this.soil, required this.irrigation, required this.size});
}
