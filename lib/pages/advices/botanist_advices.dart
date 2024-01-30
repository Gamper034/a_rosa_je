import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BotanistAdvices extends StatelessWidget {
  final Guard guard;

  static const List<String> monthNames = [
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

  const BotanistAdvices({super.key, required this.guard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Conseils de Botanistes',
          style: ArosajeTextStyle.AppBarTextStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Garde:', style: ArosajeTextStyle.titleLightTextStyle),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16.0,
                          backgroundImage: NetworkImage(guard.owner.avatar),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          guard.owner.firstname +
                              " " +
                              guard.owner.lastname.substring(0, 1) +
                              ".",
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
                          guard.startDate.day.toString() +
                              " " +
                              monthNames[guard.startDate.month - 1] +
                              " - " +
                              guard.endDate.day.toString() +
                              " " +
                              monthNames[guard.endDate.month - 1],
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          guard.city + " " + guard.zipCode,
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            SizedBox(height: 25),
            CustomButton(
              onPressed: () => {},
              label: 'Donner un conseil',
              buttonColor: primaryColor,
              textColor: Colors.white,
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Align(
                alignment: Alignment.center,
                child: Text('Aucun conseil pour le moment.',
                    style: ArosajeTextStyle.regularGreyTextStyle),
              ),
            )
          ],
        ),
      ),
    );
  }
}
