import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  const ProfileScreen({required this.onThemeToggle, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.w900)), actions: [IconButton(onPressed: onThemeToggle, icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode))]),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Center(child: Column(children: [const CircleAvatar(radius: 48, backgroundColor: AppTheme.lightGreen, child: Icon(Icons.person, size: 54, color: AppTheme.green)), const SizedBox(height: 12), Text('Jatin Kanara', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)), const SizedBox(height: 4), const Text('jatin@example.com'), const SizedBox(height: 20), OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit_outlined), label: const Text('Edit profile'))])),
      const SizedBox(height: 24),
      _group(context, 'Farm account', [const _Row(Icons.location_on_outlined, 'Location', 'Ahmedabad, Gujarat'), const _Row(Icons.agriculture_outlined, 'Farms', '2 farms • 13.7 acres'), const _Row(Icons.eco_outlined, 'Crops', '12 active crops')]),
      const SizedBox(height: 16),
      _group(context, 'Preferences', [_Row(Icons.language, 'Language', 'English', onTap: () => showModalBottomSheet(context: context, builder: (_) => const SafeArea(child: Padding(padding: EdgeInsets.all(24), child: Text('Language settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))))), const _Row(Icons.notifications_none, 'Notifications', 'Enabled'), _Row(Icons.dark_mode_outlined, 'Appearance', 'System default', onTap: onThemeToggle)]),
      const SizedBox(height: 16),
      _group(context, 'Account', [const _Row(Icons.security_outlined, 'Privacy & security', ''), _Row(Icons.logout, 'Log out', '', onTap: () {})]),
    ]),
  );

  Widget _group(BuildContext c, String title, List<Widget> children) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppTheme.green)), const SizedBox(height: 8), Card(child: Column(children: children))]);
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String title, value;
  final VoidCallback? onTap;
  const _Row(this.icon, this.title, this.value, {this.onTap});
  @override
  Widget build(BuildContext c) => ListTile(onTap: onTap, leading: Icon(icon, color: AppTheme.green), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), trailing: Row(mainAxisSize: MainAxisSize.min, children: [if (value.isNotEmpty) Text(value, style: Theme.of(c).textTheme.bodySmall), if (onTap != null) const Icon(Icons.chevron_right)]));
}
