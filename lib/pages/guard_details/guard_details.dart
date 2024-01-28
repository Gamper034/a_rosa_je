import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/widgets/card_plant.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/Models/guard.dart';

class GuardDetails extends StatefulWidget {
  const GuardDetails({super.key, required this.guard});
  final Guard guard;

  @override
  State<GuardDetails> createState() => _GuardDetailsState();
}

class _GuardDetailsState extends State<GuardDetails> {
  final monthNames = [
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

  Widget getBadgeEnCours() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.hourglass,
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
    );
  }

  Widget getBadgeTermine() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.bookmark,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 10),
            Text(
              'Terminé',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBadgeAVenir() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.calendar,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 10),
            Text(
              'A venir',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBadgeEnAttente() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.hourglass,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 10),
            Text(
              'En attente',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBadgeDisponible() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.check,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 10),
            Text(
              'Disponible',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBadge() {
    switch (widget.guard.getStatus()) {
      case 'En cours':
        return getBadgeEnCours();
      case 'Terminé':
        return getBadgeTermine();
      case "A venir":
        return getBadgeAVenir();
      case "En attente":
        return getBadgeEnAttente();
      default:
        return getBadgeDisponible();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/placeholders/plant.jpg'),
                    // image: NetworkImage(
                    //   'http://localhost:2000/uploads/${widget.guard.plant[0].image}',
                    // ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          LucideIcons.chevronLeft,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    //Badge de validation
                    getBadge(),
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
                                widget.guard.owner.firstname +
                                    " " +
                                    widget.guard.owner.lastname
                                        .substring(0, 1) +
                                    ".",
                                style:
                                    TextStyle(color: textColor, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.guard.startDate.day.toString() +
                                    " " +
                                    monthNames[widget.guard.startDate.month] +
                                    " - " +
                                    widget.guard.endDate.day.toString() +
                                    " " +
                                    monthNames[widget.guard.endDate.month],
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.guard.city + " " + widget.guard.zipCode,
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

                    Column(
                      children: [
                        for (var plant in widget.guard.plants)
                          CardPlant(
                            plant: plant,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
