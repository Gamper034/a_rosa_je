import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/widgets/card_plant.dart';
import 'package:a_rosa_je/widgets/status_badge_guard/status_badge.dart';
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
  late Guard guard;
  GuardService guardService = GuardService();
  late GuardStatus status;

  @override
  void initState() {
    guard = widget.guard;
    status = guardService.getStatus(guard);
    super.initState();
    print('initState');
  }

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

  // Align getBadgeEnCours() {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Container(
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         color: Colors.blue,
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             LucideIcons.hourglass,
  //             color: Colors.white,
  //             size: 18,
  //           ),
  //           SizedBox(width: 10),
  //           Text(
  //             'En cours',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Align getBadgeTermine() {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Container(
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         color: Colors.grey,
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             LucideIcons.bookmark,
  //             color: Colors.white,
  //             size: 18,
  //           ),
  //           SizedBox(width: 10),
  //           Text(
  //             'Terminé',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Align getBadgeAVenir() {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Container(
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         color: Colors.green,
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             LucideIcons.calendar,
  //             color: Colors.white,
  //             size: 18,
  //           ),
  //           SizedBox(width: 10),
  //           Text(
  //             'A venir',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Align getBadgeEnAttente() {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Container(
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         color: Colors.orange,
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             LucideIcons.hourglass,
  //             color: Colors.white,
  //             size: 18,
  //           ),
  //           SizedBox(width: 10),
  //           Text(
  //             'En attente',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Align getBadgeDisponible() {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Container(
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         color: Colors.green,
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             LucideIcons.check,
  //             color: Colors.white,
  //             size: 18,
  //           ),
  //           SizedBox(width: 10),
  //           Text(
  //             'Disponible',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget getBadge() {
  //   GuardService guardService = GuardService();
  //   GuardStatus status = guardService.getStatus(guard);
  //   switch (status) {
  //     case GuardStatus.enCours:
  //       return getBadgeEnCours();
  //     case GuardStatus.termine:
  //       return getBadgeTermine();
  //     case GuardStatus.aVenir:
  //       return getBadgeAVenir();
  //     case GuardStatus.enAttente:
  //       return getBadgeEnAttente();
  //     default:
  //       return getBadgeDisponible();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('build');
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
                    image: NetworkImage(
                      'http://${DataApi.getHost()}:2000/uploads/${guard.plants[0].image}',
                    ),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StatusBadge.getBadgeStatus(status),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16.0,
                                backgroundImage:
                                    NetworkImage(guard.owner.avatar),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(width: 10),
                              Text(
                                guard.owner.firstname +
                                    " " +
                                    guard.owner.lastname.substring(0, 1) +
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
                      buttonColor: secondaryColor,
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
                        for (var plant in guard.plants)
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
