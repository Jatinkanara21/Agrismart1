import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;
  const SectionTitle(this.title, {this.action, this.onTap, super.key});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)), if (action != null) TextButton(onPressed: onTap, child: Text(action!))]);
}

class StatCard extends StatelessWidget {
  final IconData icon; final String value, label;
  const StatCard({required this.icon, required this.value, required this.label, super.key});
  @override
  Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.25))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: AppTheme.green), const SizedBox(height: 12), Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)), Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12))])));
}

class ActionTile extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap;
  const ActionTile({required this.icon, required this.label, required this.onTap, super.key});
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Container(width: 92, padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.lightGreen, borderRadius: BorderRadius.circular(18)), child: Column(children: [CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(icon, color: AppTheme.green)), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))])));
}

class ProgressBar extends StatelessWidget {
  final int value;
  const ProgressBar(this.value, {super.key});
  @override
  Widget build(BuildContext context) => ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: value / 100, minHeight: 8, backgroundColor: AppTheme.lightGreen, color: AppTheme.green));
}
