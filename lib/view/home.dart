import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/theme/theme_model.dart';
import 'package:transportasi_11/view/Ticket/TicketPage.dart';
import 'package:transportasi_11/view/Reviews/reviewPage.dart';
import 'package:transportasi_11/view/Ticket/inputHomePage.dart';
import 'package:transportasi_11/view/view_list.dart';
import 'package:transportasi_11/view/topbar2.dart';
import 'package:transportasi_11/view/grid.dart';
import 'package:transportasi_11/view/view_list.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:transportasi_11/view/profile/profile.dart';

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
      InputHome(loggedIn: widget.loggedIn),
      TicketHomePage(loggedIn: widget.loggedIn),
      ReviewPage(),
      ProfileView(
        id: widget.loggedIn.id!,
        name: widget.loggedIn.name!,
        email: widget.loggedIn.email!,
        fullName: widget.loggedIn.fullName!,
        noTelp: widget.loggedIn.noTelp!,
        password: widget.loggedIn.password!,
        Profpicture: widget.loggedIn.profilePicture!,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("KAI tapi boong"),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     themeNotifier.isDark
      //         ? themeNotifier.isDark = false
      //         : themeNotifier.isDark = true;
      //   },
      //   child:
      //       Icon(themeNotifier.isDark ? Icons.dark_mode : Icons.light_mode),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 10),
        backgroundColor: Color.fromARGB(255, 206, 205, 205),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 34, 102, 141),
              ),
              label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_subway,
                color: Color.fromARGB(255, 34, 102, 141),
              ),
              label: "Kereta"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Color.fromARGB(255, 34, 102, 141),
              ),
              label: 'Ticket Saya'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.airplane_ticket,
                color: Color.fromARGB(255, 34, 102, 141),
              ),
              label: "Promo"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 34, 102, 141),
              ),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOption.elementAt(_selectedIndex),
    );
  }
}
