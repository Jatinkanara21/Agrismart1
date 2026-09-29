import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/agri_models.dart';
import '../../services/mock_data.dart';
import '../../widgets/agri_widgets.dart';
import '../crops/crops_screen.dart';
import '../disease_detection/disease_screen.dart';
import '../market/market_screen.dart';
import '../profile/profile_screen.dart';
import '../weather/weather_screen.dart';
import '../farm/farm_screen.dart';
import '../notifications/notifications_screen.dart';
import '../ai_tools/fertilizer_screen.dart';
import '../ai_tools/yield_prediction_screen.dart';
import '../ai_tools/pest_risk_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomeScreen({required this.onThemeToggle, super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _Dashboard(onThemeToggle: widget.onThemeToggle, onTab: (i) => setState(() => tab = i)),
      const CropsScreen(),
      const DiseaseScreen(),
      const MarketScreen(),
      ProfileScreen(onThemeToggle: widget.onThemeToggle),
    ];

    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grass_outlined), selectedIcon: Icon(Icons.grass), label: 'Crops'),
          NavigationDestination(icon: Icon(Icons.document_scanner_outlined), selectedIcon: Icon(Icons.document_scanner), label: 'Scan'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Market'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final ValueChanged<int> onTab;

  const _Dashboard({required this.onThemeToggle, required this.onTab});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(milliseconds: 700)),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 30),
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(color: AppTheme.lightGreen, shape: BoxShape.circle),
                  child: const Icon(Icons.agriculture_rounded, color: AppTheme.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good morning, Jatin', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                      Text('Your farm at a glance', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                  icon: const Badge(label: Text('3'), child: Icon(Icons.notifications_none_rounded)),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppTheme.deepGreen, AppTheme.green],
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Farm conditions', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                        SizedBox(height: 6),
                        Text('28°C', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                        SizedBox(height: 4),
                        Text('Partly cloudy • 72% humidity', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(.16), shape: BoxShape.circle),
                    child: const Icon(Icons.wb_sunny_rounded, color: Colors.white, size: 36),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle('Farm overview'),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(child: StatCard(icon: Icons.grass, value: '12', label: 'Crops')),
                SizedBox(width: 10),
                Expanded(child: StatCard(icon: Icons.eco, value: '8', label: 'Active')),
                SizedBox(width: 10),
                Expanded(child: StatCard(icon: Icons.agriculture, value: '2', label: 'Ready')),
              ],
            ),
            const SizedBox(height: 24),
            const SectionTitle('AI Farm Tools'),
            const SizedBox(height: 6),
            Text('Use AgriSmart intelligence to understand your crops.', style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.45,
              children: [
                _AiToolCard(icon: Icons.spa_rounded, title: 'Crop Advisor', subtitle: 'Find a suitable crop', color: AppTheme.green, onTap: () => onTab(1)),
                _AiToolCard(icon: Icons.science_rounded, title: 'Fertilizer', subtitle: 'Get nutrient guidance', color: const Color(0xFF7B5E35), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FertilizerScreen()))),
                _AiToolCard(icon: Icons.insights_rounded, title: 'Yield Prediction', subtitle: 'Estimate crop yield', color: const Color(0xFF2D6A8A), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const YieldPredictionScreen()))),
                _AiToolCard(icon: Icons.bug_report_rounded, title: 'Pest Risk', subtitle: 'Check risk level', color: const Color(0xFFB66A1C), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PestRiskScreen()))),
                _AiToolCard(icon: Icons.document_scanner_rounded, title: 'Disease Scan', subtitle: 'Analyze a leaf image', color: const Color(0xFF8A4D72), onTap: () => onTab(2)),
                _AiToolCard(
                  icon: Icons.cloud_outlined,
                  title: 'Weather',
                  subtitle: 'View farm conditions',
                  color: const Color(0xFF427A9B),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeatherScreen())),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const SectionTitle('Quick actions'),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ActionTile(icon: Icons.add_circle_outline, label: 'Add Crop', onTap: () => onTab(1)),
                  const SizedBox(width: 10),
                  ActionTile(icon: Icons.document_scanner, label: 'Scan Disease', onTap: () => onTab(2)),
                  const SizedBox(width: 10),
                  ActionTile(icon: Icons.cloud_outlined, label: 'Weather', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeatherScreen()))),
                  const SizedBox(width: 10),
                  ActionTile(icon: Icons.location_on_outlined, label: 'Farm', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FarmScreen()))),
                  const SizedBox(width: 10),
                  ActionTile(icon: Icons.storefront, label: 'Market', onTap: () => onTab(3)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SectionTitle('Your crops', action: 'View all', onTap: () => onTab(1)),
            const SizedBox(height: 12),
            ...MockData.crops.take(2).map((crop) => _CropMini(crop)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.colorScheme.primary.withOpacity(.12)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome_rounded, color: AppTheme.green),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Smart insight: Rain is likely tomorrow. Consider delaying irrigation and pesticide spraying today.',
                      style: TextStyle(fontWeight: FontWeight.w600, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _AiToolCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.18)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: color.withOpacity(.12), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 21),
              ),
              const Spacer(),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _CropMini extends StatelessWidget {
  final Crop c;
  const _CropMini(this.c);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.18)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: AppTheme.lightGreen, child: Icon(Icons.grass, color: AppTheme.green)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text(c.health + ' • Harvest ' + c.harvest, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Text(c.growth.toString() + '%', style: const TextStyle(fontWeight: FontWeight.w800, color: AppTheme.green)),
            ],
          ),
          const SizedBox(height: 12),
          ProgressBar(c.growth),
        ],
      ),
    );
  }
}
