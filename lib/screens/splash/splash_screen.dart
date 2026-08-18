import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const SplashScreen({required this.onThemeToggle, super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController c;
  late Animation<double> scale, fade;
  @override void initState() { super.initState(); c=AnimationController(vsync:this,duration:const Duration(milliseconds:1300)); scale=CurvedAnimation(parent:c,curve:Curves.elasticOut); fade=CurvedAnimation(parent:c,curve:Curves.easeIn); c.forward(); Future.delayed(const Duration(milliseconds:1900),(){if(mounted) Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>OnboardingScreen(onThemeToggle: widget.onThemeToggle)));}); }
  @override void dispose(){c.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Scaffold(body: Center(child: FadeTransition(opacity:fade,child:ScaleTransition(scale:scale,child:Column(mainAxisSize:MainAxisSize.min,children:[Container(width:110,height:110,decoration:const BoxDecoration(color:AppTheme.green,shape:BoxShape.circle),child:const Icon(Icons.agriculture_rounded,color:Colors.white,size:58)),const SizedBox(height:24),Text('AgriSmart',style:Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight:FontWeight.w900,color:AppTheme.green)),const SizedBox(height:8),Text('Smart Farming. Better Harvest.',style:Theme.of(context).textTheme.bodyLarge),const SizedBox(height:28),const SizedBox(width:32,height:32,child:CircularProgressIndicator(strokeWidth:2))]))));
}
