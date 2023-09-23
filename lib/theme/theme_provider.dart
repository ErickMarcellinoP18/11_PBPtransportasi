import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportasi_11/Theme/theme_model.dart';

class ThemeProvider extends StatelessWidget {
  final Widget child;

  ThemeProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
            home: child!,
          );
        },
      ),
    );
  }

  static ThemeModel themeNotifier(BuildContext context) {
    return Provider.of<ThemeModel>(context, listen: false);
  }
}
