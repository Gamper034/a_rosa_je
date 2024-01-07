import 'package:a_rosa_je/screens/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/components/text_field.dart';
import 'package:a_rosa_je/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // Obtenir la hauteur de l'écran

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.1,
                    bottom: screenHeight * 0.05,
                  ), // 10% de la hauteur de l'écran en haut, 5% en bas
                  child: Container(
                    width: 110,
                    height: 110,
                    child:
                        Image.asset('assets/images/logos/logo_vert_noir.png'),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Je suis:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        child: CustomButton(
                          onPressed: () {},
                          label: 'Utilisateur',
                          buttonColor: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: CustomButton(
                          onPressed: () {},
                          label: 'Botaniste',
                          buttonColor: AppColors.secondaryColor,
                          textColor: AppColors.textColor,
                        ),
                      ),
                    ),
                  ]),
                ),
                Divider(
                  color: Colors.grey,
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      CustomTextField(
                          hintText: 'Prénom', color: AppColors.textColor),
                      CustomTextField(
                          hintText: 'Nom', color: AppColors.textColor),
                      CustomTextField(
                          hintText: 'Email', color: AppColors.textColor),
                      CustomTextField(
                          hintText: 'Mot de passe', color: AppColors.textColor),
                      CustomButton(
                          onPressed: () {},
                          label: "S'inscrire",
                          buttonColor: AppColors.primaryColor,
                          textColor: Colors.white),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                        text: 'Déjà inscrit ? ',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Se connecter',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ), // Remplacez par votre page d'inscription
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
