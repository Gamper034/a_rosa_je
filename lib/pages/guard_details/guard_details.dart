import 'package:a_rosa_je/pages/guard_details/guard_candidatures.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/widgets/card_plant.dart';
import 'package:a_rosa_je/widgets/status_badge_guard/status_badge.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/models/guard.dart';

class GuardDetails extends StatefulWidget {
  const GuardDetails({super.key, required this.guard});
  final Guard guard;

  @override
  State<GuardDetails> createState() => _GuardDetailsState();
}

class _GuardDetailsState extends State<GuardDetails> {
  late Map<String, dynamic> json;
  late Guard guard;
  GuardService guardService = GuardService();
  late GuardStatus status;
  DataApi dataApi = DataApi();

  @override
  void initState() {
    super.initState();
    setGuard();
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

  void setGuard() async {
    Future<Map<String, dynamic>> futureMap = dataApi.getGuard(widget.guard.id!);
    json = await futureMap;
    setState(() {
      guard = Guard.fromJson(json['body']['data']['guard']);
    });
  }

  @override
  Widget build(BuildContext context) {
    status = guardService.getStatus(guard);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'http://${DataApi.getHost()}:2000/uploads/${guard.plants[0].image}',
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 20,
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StatusBadge.getBadgeStatus(status),
                        ),
                        if (status == GuardStatus.enCours ||
                            status == GuardStatus.enAttente)
                          Align(
                            alignment: Alignment.centerRight,
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
                    //Badge de validation
                    SizedBox(height: 10),
                    if (status != GuardStatus.enCours &&
                        status != GuardStatus.enAttente)
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
                    if (status == GuardStatus.enCours)
                      Container(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(child: Text("Guardien :")),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    guard.guardian!.firstname +
                                        " " +
                                        guard.guardian!.lastname
                                            .substring(0, 1) +
                                        ".",
                                    style: TextStyle(
                                        color: textColor, fontSize: 16),
                                  ),
                                  SizedBox(width: 10),
                                  CircleAvatar(
                                    radius: 16.0,
                                    backgroundImage:
                                        NetworkImage(guard.guardian!.avatar),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (status != GuardStatus.enAttente &&
                        status != GuardStatus.aVenir)
                      Column(
                        children: [
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
                        ],
                      ),
                    if (status == GuardStatus.aVenir)
                      Column(
                        children: [
                          SizedBox(height: 20),
                          CustomButton(
                            onPressed: () {
                              dataApi.applyToGuard(guard.id!);
                            },
                            label: 'Postuler',
                            textColor: Colors.white,
                            buttonColor: primaryColor,
                            border: true,
                          ),
                        ],
                      ),

                    if (status == GuardStatus.enAttente)
                      Column(
                        children: [
                          SizedBox(height: 20),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GuardCandidature(guard: guard),
                                ),
                              );
                            },
                            label: 'Candidatures',
                            textColor: Colors.white,
                            buttonColor: primaryColor,
                            border: true,
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
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
                            color: Colors.black,
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
