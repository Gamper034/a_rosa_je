import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/theme/textstyle.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GuardDetails extends StatefulWidget {
  const GuardDetails({super.key});

  @override
  State<GuardDetails> createState() => _GuardDetailsState();
}

class _GuardDetailsState extends State<GuardDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(
            height: 200,
            width: double.infinity,
            image: AssetImage('assets/images/guzmania-1.jpg'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                //Badge de validation
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          LucideIcons.timer,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'En cours',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.user,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Jeanne M.',
                            style: TextStyle(color: textColor, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '24 Déc. - 3 Janv.',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Montpellier 34000',
                            style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: CustomButton(
                          onPressed: () {},
                          label: 'Visites',
                          buttonColor: primaryColor,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: CustomButton(
                          onPressed: () {},
                          label: 'Messages',
                          buttonColor: secondaryColor,
                          textColor: textColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                CustomButton(
                  onPressed: () {},
                  label: 'Conseils de Botanistes',
                  textColor: textColor,
                  buttonColor: Colors.white,
                  border: true,
                  icon: LucideIcons.flower2,
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Plantes à garder',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image(
                          height: 100,
                          width: 80,
                          image: AssetImage('assets/images/guzmania-1.jpg'),
                        ),
                        SizedBox(
                            width:
                                10), // Ajoutez un espace entre l'image et le texte
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fleur de maison', // Remplacez par votre titre
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Herbacé', // Remplacez par votre description
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
