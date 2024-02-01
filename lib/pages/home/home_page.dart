import 'package:a_rosa_je/pages/my_guards/my_guards.dart';
import 'package:a_rosa_je/pages/search/search_filters_page.dart';
import 'package:a_rosa_je/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/pages/profil/profil_page.dart';
import 'package:a_rosa_je/pages/publish_guard/publish_guard.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage(
      {super.key,
      this.selectedPlantTypeList = const [],
      this.selectedVille = ''});

  List<String> selectedPlantTypeList;
  String selectedVille;

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

  void navigateToSearchFilterPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => searchFiltersPage(
          selectedPlantTypeList: widget
              .selectedPlantTypeList, // Provide an empty list as default value
          selectedVille: widget.selectedVille,
        ),
      ),
    );
  }

  AppBar appBarFromIndex(int index) {
    if (index == 0) {
      return AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Dernière demandes',
                    style: ArosajeTextStyle.AppBarTextStyle,
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateToSearchFilterPage();
                  },
                  child: Icon(LucideIcons.filter),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (index == 1) {
      return AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Mes gardes',
            style: ArosajeTextStyle.AppBarTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
      );
    } else if (index == 2) {
      return AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Demande de garde',
            style: ArosajeTextStyle.AppBarTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
      );
    } else if (index == 3) {
      return AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Messages',
            style: ArosajeTextStyle.AppBarTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
      );
    } else if (index == 4) {
      return AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Mon Compte',
            style: ArosajeTextStyle.AppBarTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
      );
    }
    return AppBar();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navigate = [
      Container(
        key: ValueKey(widget.selectedPlantTypeList),
        child: SearchPage(
          selectedPlantTypeList: widget.selectedPlantTypeList,
          selectedVille: widget.selectedVille,
        ),
      ),
      Container(
        child: MyGuards(),
      ),
      Container(
        child: PublishGuard(),
      ),
      Container(
        child: Text('Messages'),
      ),
      Container(
        child: ProfilPage(),
      ),
    ];

    return Scaffold(
        appBar: appBarFromIndex(currentIndex),
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
          iconSize: 24,
          selectedLabelStyle: TextStyle(
              fontSize:
                  10), // Réduisez cette valeur pour réduire la taille du texte
          unselectedLabelStyle: TextStyle(
              fontSize:
                  10), // Réduisez cette valeur pour réduire la taille du texte
        ));
  }
}
