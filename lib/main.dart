import 'package:flutter/material.dart';
import 'package:eth_manager/features/dashboard/ui/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EtherBank',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const DashboardPage(),
    );
  }
}
