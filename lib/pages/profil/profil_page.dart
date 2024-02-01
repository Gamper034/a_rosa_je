import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/services/user.dart';
import 'package:intl/intl.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserService().getUserPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          User user = snapshot.data!;
          return Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        user.avatar,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.firstname + ' ' + user.lastname,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Inscrit(e) le ' +
                                DateFormat('d MMMM yyyy', 'fr_FR')
                                    .format(user.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          // Text(
                          //   '20 Plantes gardées',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: secondaryColor,
                  ),
                  ProfilButton(
                    onPressed: () {},
                    text: "Modifier mon profil",
                    icon: LucideIcons.pencil,
                  ),
                  ProfilButton(
                    onPressed: () {},
                    text: "Aide",
                    icon: LucideIcons.helpCircle,
                  ),
                  //Bouton pour déconnecter l'utilisateur
                  ProfilButton(
                    onPressed: () => UserService.logout(context),
                    text: "Déconnexion",
                    icon: LucideIcons.logOut,
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ProfilButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  ProfilButton({
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Colors.transparent;
            return Colors
                .transparent; // Utilisez la couleur transparente pour l'effet de pression
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 22,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
