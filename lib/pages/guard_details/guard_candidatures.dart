import 'package:a_rosa_je/models/application.dart';
import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GuardCandidature extends StatefulWidget {
  GuardCandidature({super.key, required this.guard});
  Guard guard;

  @override
  State<GuardCandidature> createState() => _GuardCandidatureState();
}

class _GuardCandidatureState extends State<GuardCandidature> {
  late List<Application>? applications;
  late Guard guard;
  DataApi dataApi = DataApi();

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

  @override
  void initState() {
    guard = widget.guard;
    applications = widget.guard.applications;
    super.initState();
  }

  Container applicantCard(Application application) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
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
                Column(
                  children: [
                    Text(
                      application.userFirstName +
                          " " +
                          application.userLastName.substring(0, 1) +
                          ".",
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    Text(
                      application.nbGuardsDonebyUser.toString() +
                          (application.nbGuardsDonebyUser < 2
                              ? " garde effectuée"
                              : " gardes effectuées"),
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  dataApi.removeApply(application.id);
                  setState(() {
                    guard.applications!.remove(application);
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    child: Icon(
                      LucideIcons.x,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  dataApi.confirmApply(application.id);
                  setState(() {
                    guard.applications!.clear();
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    child: Icon(
                      LucideIcons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidatures'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Garde :',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                                color: secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: secondaryColor,
                height: 2,
              ),
              SizedBox(height: 20),
              if (applications == null || applications!.length == 0)
                Text('Aucune candidature pour le moment'),
              if (applications != null && applications!.length > 0)
                for (var application in applications!)
                  applicantCard(application),
            ],
          ),
        ),
      ),
    );
  }
}
