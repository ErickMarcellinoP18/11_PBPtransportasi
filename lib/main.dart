import 'package:flutter/material.dart';
import 'package:transportasi_11/view/login.dart';
import 'package:transportasi_11/view/register.dart';
import 'package:transportasi_11/theme/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/data/user.dart';

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
        primarySwatch: Colors.blue,
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
