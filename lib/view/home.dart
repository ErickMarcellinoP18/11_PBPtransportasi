import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportasi_11/theme/theme_model.dart';
import 'package:transportasi_11/theme/theme_prefrences.dart';
import 'package:transportasi_11/view/view_list.dart';
import 'package:transportasi_11/view/grid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOption = <Widget>[
    Padding(
      padding: EdgeInsets.all(8.0),
      child: GridExpandable(),
    ),
    ListNamaView(),
    Center(
      child: Text(
        'Index 3: Profile',
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("KAI tapi boong"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              themeNotifier.isDark
                  ? themeNotifier.isDark = false
                  : themeNotifier.isDark = true;
            },
            child:
                Icon(themeNotifier.isDark ? Icons.dark_mode : Icons.light_mode),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: 'List'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          body: _widgetOption.elementAt(_selectedIndex),
        );
      },
    );
  }
}
