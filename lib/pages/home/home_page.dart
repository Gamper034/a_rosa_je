import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/pages/profil/profil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<AppBar> _appBar = [
    AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text('Dernière demandes'),
      ),
      backgroundColor: Colors.white,
    ),
    AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text('Mes gardes'),
      ),
      backgroundColor: Colors.white,
    ),
    AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text('Demande de garde'),
      ),
      backgroundColor: Colors.white,
    ),
    AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text('Messages'),
      ),
      backgroundColor: Colors.white,
    ),
    AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text('Profil'),
      ),
      backgroundColor: Colors.white,
    ),
  ];

  List<Widget> _navigate = [
    Container(
      child: Text('Recherche'),
    ),
    Container(
      child: Text('Gardes'),
    ),
    Container(
      child: Text('Publier'),
    ),
    Container(
      child: Text('Messages'),
    ),
    Container(
      child: ProfilPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar.elementAt(currentIndex),
        body: Center(
          child: _navigate.elementAt(currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.search),
              label: 'Recherche',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.flower2),
              label: 'Gardes',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.plusSquare),
              label: 'Publier',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.messagesSquare),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user),
              label: 'Mon Compte',
            ),
          ],
          iconSize: 25,
          selectedLabelStyle: TextStyle(
              fontSize:
                  11), // Réduisez cette valeur pour réduire la taille du texte
          unselectedLabelStyle: TextStyle(
              fontSize:
                  11), // Réduisez cette valeur pour réduire la taille du texte
        ));
  }
}
