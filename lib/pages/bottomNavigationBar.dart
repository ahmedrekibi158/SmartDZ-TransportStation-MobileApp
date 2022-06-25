/*import 'package:app0/pages/profilPage.dart';
import 'package:flutter/material.dart';

import '../param/colors.dart';
import 'Dashboard.dart';
import 'historiquePage.dart';
import 'rechercheVoyage.dart';

int _selectedIndex = 0;
Widget bottomNavigationBar() {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Page d\'accueil',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search_outlined),
        label: 'Recherche',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history_outlined),
        label: 'Historique',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
        backgroundColor: Colors.blue,
      ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: whiteColor,
    onTap: _onItemTapped,
  );
}

_onItemTapped(int index) {
  print("index $index");
  _selectedIndex = index;
}

Widget screen(height, width, context) {
  if (_selectedIndex == 0)
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ));

  if (_selectedIndex == 1)
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => recherchePage(),
        ));

  if (_selectedIndex == 2)
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => historiquePage(),
        ));
  if (_selectedIndex == 3)
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => profilePage(),
        ));
  return Container();
}
*/