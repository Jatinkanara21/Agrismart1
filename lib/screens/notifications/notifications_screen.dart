import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final items = [
    ('Rain alert', 'Rain expected tomorrow. Review irrigation plans.', Icons.cloud, Colors.blue),
    ('Crop health', 'Cotton field needs attention based on recent checks.', Icons.eco, Colors.orange),
    ('Irrigation reminder', 'Wheat field irrigation is due this evening.', Icons.water_drop, Colors.cyan),
    ('Harvest reminder', 'Tomato crop is approaching harvest window.', Icons.agriculture, Colors.green),
    ('Market update', 'Wheat price increased 3.8% at Ahmedabad APMC.', Icons.trending_up, Colors.purple),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w900)), actions: [TextButton(onPressed: () {}, child: const Text('Mark all read'))]),
    body: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (c, i) {
        final item = items[i];
        return Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: CircleAvatar(backgroundColor: item.$4.withOpacity(.12), child: Icon(item.$3, color: item.$4)),
          title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text(item.$2),
          trailing: i < 3 ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)) : null,
        ));
      },
    ),
  );
}
