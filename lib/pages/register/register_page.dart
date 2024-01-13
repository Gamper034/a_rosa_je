import 'package:flutter/material.dart';
import 'package:a_rosa_je/widgets/button.dart';
import 'package:a_rosa_je/pages/login/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:a_rosa_je/pages/register/user_form.dart';
import 'package:a_rosa_je/pages/register/botanist_form.dart';
import 'package:a_rosa_je/theme/theme.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isUserForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 80,
                      bottom: 30,
                    ),
                    child: Container(
                      width: 110,
                      height: 110,
                      child: Image.asset(
                          'assets/images/logos/png/logo_vert_noir.png'),
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
                  SizedBox(height: 10),
                  Container(
                    child: Row(children: [
                      Expanded(
                        child: CustomButton(
                          buttonColor:
                              isUserForm ? primaryColor : secondaryColor,
                          textColor: isUserForm ? Colors.white : textColor,
                          onPressed: () {
                            setState(() {
                              isUserForm = true;
                            });
                          },
                          label: 'Utilisateur',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          buttonColor:
                              isUserForm ? secondaryColor : primaryColor,
                          textColor: isUserForm ? textColor : Colors.white,
                          onPressed: () {
                            setState(() {
                              isUserForm = false;
                            });
                          },
                          label: 'Botaniste',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.grey,
                    height: 20,
                  ),
                  SizedBox(height: 5),

                  // ...

                  isUserForm ? UserForm() : BotanistForm(),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: 'Déjà inscrit ? ',
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Se connecter',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
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
      ),
    );
  }
}
