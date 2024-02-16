import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todonow_lite/pages/home_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDoNow -lite',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const HomePage(),
    );
  }
}
