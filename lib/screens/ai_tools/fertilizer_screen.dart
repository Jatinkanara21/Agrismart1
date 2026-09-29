import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../services/ml_api_service.dart';

class FertilizerScreen extends StatefulWidget { const FertilizerScreen({super.key}); @override State<FertilizerScreen> createState()=>_FertilizerScreenState(); }
class _FertilizerScreenState extends State<FertilizerScreen> {
  final f=GlobalKey<FormState>();
  final t=TextEditingController(text:'25'),h=TextEditingController(text:'60'),m=TextEditingController(text:'40'),n=TextEditingController(text:'50'),k=TextEditingController(text:'30'),p=TextEditingController(text:'40');
  String soil='Loamy',crop='Rice'; bool loading=false; String? result,error;
  @override void dispose(){for(final c in [t,h,m,n,k,p])c.dispose();super.dispose();}
  double num(TextEditingController c)=>double.parse(c.text);
  Future<void> submit() async {if(!f.currentState!.validate())return;setState(()=>{loading=true,error=null,result=null});try{final r=await MlApiService.fertilizer(temperature:num(t),humidity:num(h),moisture:num(m),soilType:soil,cropType:crop,nitrogen:num(n),potassium:num(k),phosphorous:num(p));if(mounted)setState(()=>result=(r['fertilizer']??r['recommendation']??'Result returned').toString());}catch(e){if(mounted)setState(()=>error=e.toString().replaceFirst('Exception: ',''));}finally{if(mounted)setState(()=>loading=false);}}
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Fertilizer Advisor')),body:Form(key:f,child:ListView(padding:const EdgeInsets.all(18),children:[_intro(c,'Enter field conditions. The result comes from the configured AgriSmart ML service.'),...[_field(t,'Temperature'),_field(h,'Humidity'),_field(m,'Soil moisture')],_drop('Soil type',soil,['Loamy','Sandy','Clayey','Black','Red'],(v)=>setState(()=>soil=v)),_drop('Crop type',crop,['Rice','Wheat','Maize','Cotton','Chickpea','Groundnut','Sugarcane','Potato','Soybean','Millet'],(v)=>setState(()=>crop=v)),_field(n,'Nitrogen'),_field(k,'Potassium'),_field(p,'Phosphorous'),FilledButton.icon(onPressed:loading?null:submit,icon:const Icon(Icons.auto_awesome),label:Text(loading?'Analyzing…':'Get Recommendation')),if(error!=null)_msg(c,error!,true),if(result!=null)_msg(c,'Recommended fertilizer: $result',false)])));
  Widget _field(TextEditingController c,String l)=>Padding(padding:const EdgeInsets.only(bottom:12),child:TextFormField(controller:c,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:InputDecoration(labelText:l),validator:(v)=>double.tryParse(v??'')==null?'Enter a valid number':null));
  Widget _drop(String l,String v,List<String> items,ValueChanged<String> cb)=>Padding(padding:const EdgeInsets.only(bottom:12),child:DropdownButtonFormField<String>(value:v,decoration:InputDecoration(labelText:l),items:items.map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(x)=>cb(x!)));
  Widget _intro(BuildContext c,String s)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:AppTheme.lightGreen,borderRadius:BorderRadius.circular(18)),child:Text(s,style:const TextStyle(fontWeight:FontWeight.w700)));
  Widget _msg(BuildContext c,String s,bool e)=>Container(margin:const EdgeInsets.only(top:16),padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:e?Theme.of(c).colorScheme.errorContainer:AppTheme.lightGreen,borderRadius:BorderRadius.circular(16)),child:Text(s,style:const TextStyle(fontWeight:FontWeight.w700)));
}
