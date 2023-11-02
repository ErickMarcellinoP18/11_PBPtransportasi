import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportasi_11/theme/theme_model.dart';
import 'package:transportasi_11/theme/theme_prefrences.dart';
import 'package:transportasi_11/view/TicketPage.dart';
import 'package:transportasi_11/view/view_list.dart';
import 'package:transportasi_11/view/topbar2.dart';
import 'package:transportasi_11/view/grid.dart';
import 'package:transportasi_11/view/view_list.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/profile.dart';

class HomeView extends StatefulWidget {
  final User loggedIn;
  const HomeView({super.key, required this.loggedIn});

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

  List<Widget> _widgetOption = [];

  @override
  void initState() {
    _widgetOption = <Widget>[
      Padding(
        padding: EdgeInsets.all(8.0),
        child: GridExpandable(),
      ),
      TicketHomePage(loggedIn: widget.loggedIn),
      topBar(),
      ProfileView(
        id: widget.loggedIn.id!,
        name: widget.loggedIn.name!,
        email: widget.loggedIn.email!,
        fullName: widget.loggedIn.fullName!,
        noTelp: widget.loggedIn.noTelp!,
        password: widget.loggedIn.password!,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text("KAI tapi boong"),
          // ),
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
                  label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.directions_subway), label: "Kereta"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: 'Ticket Saya'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.airplane_ticket), label: "Promo"),
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
