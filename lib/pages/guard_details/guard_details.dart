import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/pages/advices/guard/botanist_advices.dart';
import 'package:a_rosa_je/pages/visits/guard_visits.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/color.dart';
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
  List<Advice> advices = [];
  List<Visit> visits = [];
  late Guard guard;
  late Map<String, dynamic> json;
  GuardService guardService = GuardService();
  late GuardStatus status;
  late List<Visit> visitsList;

  @override
  void initState() {
    guard = widget.guard;
    status = guardService.getStatus(guard);
    visitsList = widget.guard.visits!;
    super.initState();
    // print('initState');
  }

  @override
  Widget build(BuildContext context) {
    // print('build');
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
                                    GuardService
                                        .monthNames[guard.startDate.month - 1] +
                                    " - " +
                                    guard.endDate.day.toString() +
                                    " " +
                                    GuardService
                                        .monthNames[guard.endDate.month - 1],
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
                              onPressed: () async {
                                // visits = [];
                                // DataApi dataApi = DataApi();

                                // Future<Map<String, dynamic>> futureMap =
                                //     dataApi.getGuardVisits(context, guard.id);
                                // Map<String, dynamic> json = await futureMap;
                                // print(json);
                                // List<dynamic> jsonVisits =
                                //     json['body']['data']['visits'];
                                // // print(jsonVisits);
                                // // visits = jsonVisits
                                // //     .map((visit) => Visit.fromJson(visit))
                                // //     .toList();

                                // if (jsonVisits != [])
                                //   for (var visit in jsonVisits) {
                                //     visits.add(Visit.fromJson(visit));
                                //   }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GuardVisitList(
                                        guard: guard, visits: visitsList),
                                  ),
                                );
                              },
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
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: () async {
                        advices = [];
                        DataApi dataApi = DataApi();

                        Future<Map<String, dynamic>> futureMap =
                            dataApi.getGuardAdvices(context, guard.id);
                        Map<String, dynamic> json = await futureMap;
                        print(await futureMap);
                        List<dynamic> jsonAdvices =
                            json['body']['data']['advices'];
                        // print(jsonAdvices);
                        // advices = jsonAdvices
                        //     .map((advice) => Advice.fromJson(advice))
                        //     .toList();
                        for (var advice in jsonAdvices) {
                          advices.add(Advice.fromJson(advice));
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BotanistGuardAdvices(
                                guard: guard, advices: advices),
                          ),
                        );
                      },
                      label: 'Conseils de Botanistes',
                      textColor: textColor,
                      buttonColor: Colors.white,
                      border: true,
                      icon: LucideIcons.flower2,
                    ),
                    SizedBox(height: 50),
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
