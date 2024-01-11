import 'package:flutter/material.dart';
import 'package:a_rosa_je/widgets/button.dart';
import 'package:a_rosa_je/pages/login_page.dart';
import 'package:a_rosa_je/widgets/toast_info.dart';
import 'package:a_rosa_je/theme/theme.dart';

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
                  child: ToastInfo(
                    height: 250,
                    backgroundColor: solidGreen,
                    textColor: Colors.white,
                    firstText: 'Votre inscription a bien été enregistrée',
                    secondText:
                        "Un administrateur doit valider votre statut de botaniste. Vous serez informé de l'avancée de cette validation",
                    icon: Image.asset('assets/images/icons/check.png'),
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
