import 'package:flutter/material.dart';
import '../../services/mock_data.dart';
import '../../widgets/agri_widgets.dart';
import '../../models/agri_models.dart';

class CropsScreen extends StatefulWidget {
  const CropsScreen({super.key});
  @override State<CropsScreen> createState() => _CropsScreenState();
}

class _CropsScreenState extends State<CropsScreen> {
  final List<Crop> crops = [...MockData.crops];

  void add() {
    showDialog(context: context, builder: (c) {
      final n = TextEditingController();
      return AlertDialog(
        title: const Text('Add crop'),
        content: TextField(controller: n, decoration: const InputDecoration(labelText: 'Crop name', prefixIcon: Icon(Icons.grass))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          FilledButton(onPressed: () { if (n.text.trim().isNotEmpty) setState(() => crops.add(Crop(name: n.text.trim(), type: 'Vegetable', soil: 'Loamy', irrigation: 'Drip', health: 'Good', growth: 10, planted: '18 Aug 2026', harvest: '18 Nov 2026'))); Navigator.pop(c); }, child: const Text('Add')),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Crops', style: TextStyle(fontWeight: FontWeight.w900)), actions: [IconButton(onPressed: add, icon: const Icon(Icons.add_circle))]),
    floatingActionButton: FloatingActionButton.extended(onPressed: add, icon: const Icon(Icons.add), label: const Text('Add Crop')),
    body: ListView(padding: const EdgeInsets.all(20), children: [Text('Track every field from seed to harvest.', style: Theme.of(context).textTheme.bodyLarge), const SizedBox(height: 20), ...crops.map((c) => _CropCard(c))]),
  );
}

class _CropCard extends StatelessWidget {
  final Crop c;
  const _CropCard(this.c);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(children: [
        Row(children: [
          Container(width: 58, height: 58, decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.grass, size: 32, color: Colors.green)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(c.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), Text('${c.type} • ${c.soil} soil'), const SizedBox(height: 5), Text('Health: ${c.health}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w700))])),
          Text('${c.growth}%', style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.green)),
        ]),
        const SizedBox(height: 16), ProgressBar(c.growth), const SizedBox(height: 14),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Planted ${c.planted}'), Text('Harvest ${c.harvest}')]),
        const SizedBox(height: 10),
        Align(alignment: Alignment.centerRight, child: TextButton.icon(
          onPressed: () => showModalBottomSheet(context: context, builder: (_) => Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(c.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)), const SizedBox(height: 16), Text('Water: ${c.irrigation}'), Text('Soil: ${c.soil}'), const Text('Temperature: 20–30°C'), Text('Expected harvest: ${c.harvest}'), const SizedBox(height: 12)]))),
          icon: const Icon(Icons.arrow_forward), label: const Text('View details'),
        )),
      ]),
    ),
  );
}
