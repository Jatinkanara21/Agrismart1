import 'package:flutter/material.dart';
import '../../services/mock_data.dart';

class FarmScreen extends StatefulWidget {
  const FarmScreen({super.key});
  @override State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
  final farms = [...MockData.farms];

  void add() {
    showDialog(context: context, builder: (_) {
      final n = TextEditingController();
      return AlertDialog(title: const Text('Add farm'), content: TextField(controller: n, decoration: const InputDecoration(labelText: 'Farm name')), actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () { if (n.text.isNotEmpty) setState(() => farms.add(MockData.farms.first)); Navigator.pop(context); }, child: const Text('Save')),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Farms', style: TextStyle(fontWeight: FontWeight.w900)), actions: [IconButton(onPressed: add, icon: const Icon(Icons.add))]),
    floatingActionButton: FloatingActionButton.extended(onPressed: add, icon: const Icon(Icons.add), label: const Text('Add Farm')),
    body: ListView(padding: const EdgeInsets.all(20), children: farms.map((f) => Card(margin: const EdgeInsets.only(bottom: 14), child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Container(width: 54, height: 54, decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.location_on, color: Colors.green)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(f.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), Text(f.location)])), Text('${f.size} acres', style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.green))]),
      const Divider(height: 28), Wrap(spacing: 8, runSpacing: 8, children: [Chip(label: Text(f.soil)), Chip(label: Text(f.irrigation)), const Chip(label: Text('3 crops'))]), const SizedBox(height: 8),
      TextButton.icon(onPressed: () {}, icon: const Icon(Icons.map_outlined), label: const Text('View location')),
    ])))).toList(),
  );
}
