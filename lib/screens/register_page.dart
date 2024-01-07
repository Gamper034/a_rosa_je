import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/forms/botaniste_form.dart';
import 'package:a_rosa_je/forms/user_form.dart';
import 'package:a_rosa_je/screens/login_page.dart';
import 'package:a_rosa_je/constants.dart';
import 'package:flutter/gestures.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isUserForm = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                  ),
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
                      child: CustomButton(
                        buttonColor: isUserForm
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                        textColor:
                            isUserForm ? Colors.white : AppColors.textColor,
                        onPressed: () {
                          setState(() {
                            isUserForm = true;
                          });
                        },
                        label: 'Utilisateur',
                        // Ajoutez les autres propriétés pour conserver le style du bouton
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        buttonColor: isUserForm
                            ? AppColors.secondaryColor
                            : AppColors.primaryColor,
                        textColor:
                            isUserForm ? AppColors.textColor : Colors.white,
                        onPressed: () {
                          setState(() {
                            isUserForm = false;
                          });
                        },
                        label: 'Botaniste',
                        // Ajoutez les autres propriétés pour conserver le style du bouton
                      ),
                    ),
                  ]),
                ),
                Divider(
                  color: Colors.grey,
                  height: 20,
                ),

                // ...

                isUserForm ? UserForm() : BotanistForm(),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
