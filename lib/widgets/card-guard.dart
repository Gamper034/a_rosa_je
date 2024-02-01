import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/pages/guard_details/guard_details.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/widgets/status_badge_guard/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/theme/theme.dart';

// ignore: must_be_immutable
class GuardCard extends StatelessWidget {
  GuardCard(
      {super.key,
      required this.guard,
      required this.myGuards,
      required this.byCurrentUser});
  DateTime now = DateTime.now();



  final Guard guard;

  bool myGuards;
  bool byCurrentUser;

  bool get isPassed {
    DateTime endDate =
        DateTime(guard.endDate.year, guard.endDate.month, guard.endDate.day);
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return endDate.isBefore(today);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      // margin: EdgeInsets.all(10),
      // height: 290,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuardDetails(guard: guard),
            ),
          );
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
                        if (isPassed)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.0),
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
                                    height: 24,
                                    width: 94,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          LucideIcons.flower2,
                                          size: 18,
                                        ),
                                        if (guard.plants.length > 1)
                                          Text(
                                            guard.plants.length.toString() +
                                                " plantes",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        if (guard.plants.length <= 1)
                                          Text(
                                            guard.plants.length.toString() +
                                                " plante",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                      ],
                                    )),
                              )),
                        ),
                        myGuards ? _badgeStatusGuard() : Container(),
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
                  child: byCurrentUser ? _guardianStatus() : _OwnerInfo(),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        guard.startDate.day.toString() +
                            " " +
                            GuardService.monthNames[guard.startDate.month - 1] +
                            " - " +
                            guard.endDate.day.toString() +
                            " " +
                            GuardService.monthNames[guard.endDate.month - 1],
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      byCurrentUser ? Container() : _cityInfo(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _OwnerInfo() {
    return Row(
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
    );
  }

  _guardianStatus() {
    bool hasGuard = guard.guardianId != null;
    return Row(
      children: [
        Icon(
          hasGuard ? LucideIcons.check : LucideIcons.hourglass,
          color: hasGuard ? primaryColor : warningColor,
          size: 18,
        ),
        SizedBox(width: 5),
        Text(
          hasGuard ? "Gardien validé" : "Recherche de gardien",
          style: TextStyle(
            color: hasGuard ? primaryColor : warningColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  _cityInfo() {
    return Text(
      guard.city + " " + guard.zipCode,
      style: TextStyle(
          color: secondaryTextColor, fontSize: 12, fontWeight: FontWeight.w400),
    );
  }

  _badgeStatusGuard() {
    GuardService guardService = GuardService();
    GuardStatus status = guardService.getStatus(guard);
    return Positioned(
        top: 10, left: 10, child: StatusBadge.getBadgeStatus(status));
  }
}
