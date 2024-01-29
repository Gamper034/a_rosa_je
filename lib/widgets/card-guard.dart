import 'package:a_rosa_je/Models/guard.dart';
import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/Models/user.dart';
import 'package:a_rosa_je/pages/guard_details/guard_details.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/theme/theme.dart';

class GuardCard extends StatelessWidget {
  GuardCard({super.key, required this.guard});

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

  final Guard guard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      // margin: EdgeInsets.all(10),
      // height: 290,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GuardDetails(guard: guard)));
        },
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              'http://${DataApi.getHost()}:2000/uploads/${guard.plants[0].image}',
                              fit: BoxFit.cover,
                            ),
                            // child: Image.asset(
                            //   //guard.plants[0].picture,
                            //   'assets/images/placeholders/plant.jpg',
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
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
                                        if (guard.plants.length > 1)
                                          Text(guard.plants.length.toString() +
                                              " plantes"),
                                        if (guard.plants.length <= 1)
                                          Text(guard.plants.length.toString() +
                                              " plante"),
                                      ],
                                    )),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                        // backgroundImage: AssetImage(
                        //     //guard.user.profilePicture,
                        //     guard.owner.avatar),
                        backgroundImage: NetworkImage(guard.owner.avatar),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 10),
                      Text(
                        guard.owner.firstname +
                            " " +
                            guard.owner.lastname.substring(0, 1) +
                            ".",
                        style: TextStyle(color: textColor, fontSize: 14),
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
                            monthNames[guard.startDate.month] +
                            " - " +
                            guard.endDate.day.toString() +
                            " " +
                            monthNames[guard.endDate.month],
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.45,
            //       child: Row(
            //         children: [
            //           CircleAvatar(
            //             radius: 20.0,
            //             backgroundImage: AssetImage(
            //                 //guard.user.profilePicture,
            //                 'assets/images/placeholders/profile.jpg'),
            //             backgroundColor: Colors.transparent,
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             guard.owner.firstname +
            //                 " " +
            //                 guard.owner.lastname.substring(0, 1) +
            //                 ".",
            //             style: TextStyle(
            //               fontSize: 16,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //         width: MediaQuery.of(context).size.width * 0.45,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Text(
            //                   guard.startDate.day.toString() +
            //                       " " +
            //                       monthNames[guard.startDate.month] +
            //                       " " +
            //                       guard.startDate.year.toString().substring(2) +
            //                       " - " +
            //                       guard.endDate.day.toString() +
            //                       " " +
            //                       monthNames[guard.endDate.month] +
            //                       " " +
            //                       guard.endDate.year.toString().substring(2),
            //                   textAlign: TextAlign.right,
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.bold, fontSize: 16),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Container(
            //                   child: Text(
            //                     guard.city + " " + guard.zipCode,
            //                     textAlign: TextAlign.right,
            //                     style: TextStyle(
            //                       color: Colors.black54,
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ],
            //         )),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
