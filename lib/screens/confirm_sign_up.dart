import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/constants.dart';
import 'package:a_rosa_je/screens/login_page.dart';
import 'package:a_rosa_je/components/toast_info.dart';

class ConfirmSignUp extends StatelessWidget {
  const ConfirmSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 80, bottom: 80),
            child: Column(
              children: [
                //Ajout du logo blanc
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/logos/logo_blanc.png'),
                ),
                Spacer(
                  flex: 1,
                ),
                //Ajout du texte de confirmation
                Container(
                  child: ToastInfo(
                    height: 250,
                    backgroundColor: AppColors.solidGreen,
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
                  height: 70,
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
