import 'package:flutter/material.dart';
import 'package:transportasi_11/view/login.dart';
import 'package:transportasi_11/theme/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:transportasi_11/view/profile.dart';

void main() {
  runApp(const MainApp());
}
 
class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
            home: ProfileView(),
          );
        },
      ),
    );
  }
}
