import 'package:flutter/material.dart';
import 'package:learn_flutter_2_udemy/2_application/core/services/theme_service.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/advice_page.dart';
import 'package:learn_flutter_2_udemy/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: const MainApp(),
      )
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context,themeService,child){
      return MaterialApp(
      themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SafeArea(
        child: AdvicerPageWrapperProvider(),
      ),
    );
    });
  }
}