import 'package:flutter/material.dart';
import 'package:transportasi_11/constant/app_constant.dart';
import 'package:transportasi_11/qr_scan/scan_qr_page.dart';
import 'package:transportasi_11/view/homePetugas.dart';
import 'package:transportasi_11/view/login.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/theme/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/reviewPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLITE',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color.fromARGB(255, 34, 102, 141)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:
                  themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
              home: const RegisterView(
                  id: null,
                  name: null,
                  email: null,
                  fullName: null,
                  noTelp: null,
                  password: null));
        },
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  ;
  return MaterialColor(color.value, swatch);
}
