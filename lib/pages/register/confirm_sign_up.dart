import 'package:flutter/material.dart';
import 'package:a_rosa_je/widgets/button.dart';
import 'package:a_rosa_je/pages/login/login_page.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ConfirmSignUp extends StatelessWidget {
  const ConfirmSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 80, bottom: 80),
            child: Column(
              children: [
                //Ajout du logo blanc
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/logos/png/logo_blanc.png'),
                ),
                Spacer(
                  flex: 1,
                ),
                //Ajout du texte de confirmation
                Container(
                  height: 250,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: solidGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          LucideIcons.badgeCheck,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Votre inscription a bien été enregistrée",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Un administrateur doit valider votre statut de botaniste. Vous serez informé de l’avancée de cette validation.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                //Ajout du bouton de retour à la page de connexion
                Container(
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    label: "Ok, j'ai compris",
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
