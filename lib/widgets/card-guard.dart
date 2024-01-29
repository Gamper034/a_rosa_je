import 'package:a_rosa_je/Models/guard.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/theme/theme.dart';

class GuardCard extends StatelessWidget {
  GuardCard(
      {super.key,
      required this.guard,
      required this.myGuards,
      required this.isMade});
  DateTime now = DateTime.now();

  final monthNames = [
    'Janv.',
    'Fév.',
    'Mars',
    'Avr.',
    'Mai',
    'Juin',
    'Juil.',
    'août',
    'Sept.',
    'Oct.',
    'Nov.',
    'Déc.'
  ];

  final Guard guard;

  bool myGuards;
  bool isMade;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      // margin: EdgeInsets.all(10),
      // height: 290,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            'http://localhost:2000/uploads/${guard.plants[0].image}',
                            fit: BoxFit.cover,
                          ),
                          // child: Image.asset(
                          //   //guard.plants[0].picture,
                          //   'assets/images/placeholders/plant.jpg',
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: Container(
                                  color: Colors.white,
                                  height: 24,
                                  width: 94,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        LucideIcons.flower2,
                                        size: 18,
                                      ),
                                      if (guard.plants.length > 1)
                                        Text(
                                          guard.plants.length.toString() +
                                              " plantes",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      if (guard.plants.length <= 1)
                                        Text(
                                          guard.plants.length.toString() +
                                              " plante",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                    ],
                                  )),
                            )),
                      ),
                      myGuards ? _badgeStatusGuard() : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: isMade ? _guardianStatus() : _OwnerInfo(),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      guard.startDate.day.toString() +
                          " " +
                          monthNames[guard.startDate.month] +
                          " - " +
                          guard.endDate.day.toString() +
                          " " +
                          monthNames[guard.endDate.month],
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    isMade ? Container() : _cityInfo(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _OwnerInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 16.0,
          // backgroundImage: AssetImage(
          //     //guard.user.profilePicture,
          //     guard.owner.avatar),
          backgroundImage: NetworkImage(guard.owner.avatar),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 10),
        Text(
          guard.owner.firstname +
              " " +
              guard.owner.lastname.substring(0, 1) +
              ".",
          style: TextStyle(color: textColor, fontSize: 14),
        ),
      ],
    );
  }

  _guardianStatus() {
    bool isGuard = guard.guardian != null;
    print(isGuard);
    return Row(
      children: [
        Icon(
          isGuard ? LucideIcons.check : LucideIcons.hourglass,
          color: isGuard ? primaryColor : warningColor,
          size: 18,
        ),
        SizedBox(width: 5),
        Text(
          isGuard ? "Gardien validé" : "Recherche de gardien",
          style: TextStyle(
            color: isGuard ? primaryColor : warningColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  _cityInfo() {
    return Text(
      guard.city + " " + guard.zipCode,
      style: TextStyle(
          color: secondaryTextColor, fontSize: 12, fontWeight: FontWeight.w400),
    );
  }

  _badgeStatusGuard() {
    //TODO: Ajouter Candidature en attente si Dans effectuées donc isMade = false et pas de gardien + Ajout opacité si terminée et revoir le traitement car Terminée affiché alors que guarde non passée
    String badgeText;
    Color badgeColor;
    IconData icon;

    if (now.isBefore(guard.startDate)) {
      // La date actuelle est avant la date de début de la garde
      badgeText = "A venir";
      badgeColor = blueBadge;
      icon = LucideIcons.calendar;
    } else if (now.isAfter(guard.endDate)) {
      // La date actuelle est après la date de fin de la garde
      badgeText = "Terminée";
      badgeColor = greenTitle;
      icon = LucideIcons.bookmarkMinus;
    } else {
      // La date actuelle est entre la date de début et la date de fin de la garde
      badgeText = "En cours";
      badgeColor = primaryColor;
      icon = LucideIcons.hourglass;
    }
    //
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        margin: EdgeInsets.only(left: 10, top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Container(
            color: badgeColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                      width:
                          4.0), // Ajoutez un espace entre l'icône et le texte
                  Text(
                    badgeText,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
