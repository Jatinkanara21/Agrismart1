import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const OnboardingScreen({required this.onThemeToggle, super.key});
  @override State<OnboardingScreen> createState()=>_OnboardingScreenState();
}
class _OnboardingScreenState extends State<OnboardingScreen>{
  final PageController p=PageController(); int index=0;
  final data=[('Smart Farming','Monitor your farm intelligently',Icons.eco_rounded),('Crop Management','Track crops and farming activities',Icons.grass_rounded),('Weather & Insights','Get weather forecasts and smart recommendations',Icons.wb_sunny_rounded)];
  void finish()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>HomeScreen(onThemeToggle:widget.onThemeToggle)));
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:Column(children:[Align(alignment:Alignment.topRight,child:TextButton(onPressed:finish,child:const Text('Skip'))),Expanded(child:PageView.builder(controller:p,itemCount:data.length,onPageChanged:(v)=>setState(()=>index=v),itemBuilder:(c,i)=>Padding(padding:const EdgeInsets.all(28),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Container(width:220,height:220,decoration:BoxDecoration(color:Colors.green.shade50,shape:BoxShape.circle),child:Icon(data[i].$3,size:100,color:Colors.green.shade700)),const SizedBox(height:42),Text(data[i].$1,textAlign:TextAlign.center,style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.w900)),const SizedBox(height:14),Text(data[i].$2,textAlign:TextAlign.center,style:Theme.of(context).textTheme.titleMedium?.copyWith(color:Theme.of(context).colorScheme.onSurfaceVariant))])))),Padding(padding:const EdgeInsets.all(24),child:Row(children:[...List.generate(3,(i)=>AnimatedContainer(duration:const Duration(milliseconds:250),margin:const EdgeInsets.only(right:6),height:7,width:index==i?28:8,decoration:BoxDecoration(color:index==i?Colors.green:Colors.green.shade200,borderRadius:BorderRadius.circular(10)))),const Spacer(),FilledButton(onPressed:()=>index==2?finish():p.nextPage(duration:const Duration(milliseconds:400),curve:Curves.easeOut),child:Padding(padding:const EdgeInsets.symmetric(horizontal:18,vertical:12),child:Text(index==2?'Get Started':'Next')))])])));
}
