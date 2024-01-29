import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StatusBadge {
  static Container badgeEnCours = Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.hourglass,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                  width: 4.0), // Ajoutez un espace entre l'icône et le texte
              Text(
                "En cours",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  static Container badgeTermine = Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        color: greenSolid,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.bookmarkMinus,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                  width: 4.0), // Ajoutez un espace entre l'icône et le texte
              Text(
                "Terminé",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  static Container badgeCandidatureEnAttente = Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        color: warningColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.hourglass,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                  width: 4.0), // Ajoutez un espace entre l'icône et le texte
              Text(
                "Candidature en attente",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  static Container badgeAVenir = Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        color: blueBadge,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.calendar,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                  width: 4.0), // Ajoutez un espace entre l'icône et le texte
              Text(
                "A venir",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  static Container badgeDefault = Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.alertTriangle,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                  width: 4.0), // Ajoutez un espace entre l'icône et le texte
              Text(
                "No badge found",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  static Container getBadgeStatus(GuardStatus status) {
    switch (status) {
      case GuardStatus.enCours:
        return badgeEnCours;
      case GuardStatus.termine:
        return badgeTermine;
      case GuardStatus.enAttente:
        return badgeCandidatureEnAttente;
      case GuardStatus.aVenir:
        return badgeAVenir;
      default:
        return badgeDefault;
    }
  }
}
