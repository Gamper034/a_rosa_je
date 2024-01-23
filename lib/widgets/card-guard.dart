import 'package:a_rosa_je/Models/guard.dart';
import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GuardCard extends StatelessWidget {
  GuardCard({super.key, required this.guard});

  final monthNames = [
    'JAN',
    'FEV',
    'MAR',
    'AVR',
    'MAI',
    'JUIN',
    'JUIL',
    'AOU',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  final Guard guard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.33,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      child: Stack(children: [
                        Container(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                //guard.plants[0].picture,
                                'assets/images/placeholders/plant.jpg',
                                fit: BoxFit.cover,
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Container(
                                    color: Colors.white,
                                    height: 30,
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(LucideIcons.flower2),
                                        Text(guard.plants.length.toString() +
                                            " plantes"),
                                      ],
                                    )),
                              )),
                        ),
                      ])))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage(
                            //guard.user.profilePicture,
                            'assets/images/placeholders/profile.jpg'),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        guard.owner.firstname +
                            " " +
                            guard.owner.lastname.substring(0, 1) +
                            ".",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            guard.startDate.day.toString() +
                                " " +
                                monthNames[guard.startDate.month] +
                                " " +
                                guard.startDate.year.toString().substring(2) +
                                " - " +
                                guard.endDate.day.toString() +
                                " " +
                                monthNames[guard.endDate.month] +
                                " " +
                                guard.endDate.year.toString().substring(2),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              guard.city + " " + guard.zipCode,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
