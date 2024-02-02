import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/plant_visit.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/pages/advices/visit/botanist_visit_advices.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../theme/theme.dart';

class VisitDetail extends StatefulWidget {
  final Visit visit;
  final Guard guard;
  const VisitDetail({Key? key, required this.visit, required this.guard})
      : super(key: key);

  @override
  State<VisitDetail> createState() => _VisitDetailState();
}

class _VisitDetailState extends State<VisitDetail> {
  late Visit visit;
  List<Advice> advices = [];

  late Guard guard;
  late List<PlantVisit> plantsVisit;

  @override
  void initState() {
    visit = widget.visit;
    guard = widget.guard;
    plantsVisit = visit.plants;
    print(plantsVisit.length);
    // print(visit);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var day = visit.date.day == 1 ? "${visit.date.day}er" : visit.date.day;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Visite - ${day} ${GuardService.fullMonthNames[visit.date.month - 1]}',
          style: ArosajeTextStyle.AppBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            widget.guard.startDate.day.toString() +
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
              SizedBox(height: 30),
              CustomButton(
                onPressed: () async {
                  advices = [];
                  DataApi dataApi = DataApi();

                  Future<Map<String, dynamic>> futureMap =
                      dataApi.getVisitAdvices(context, visit.id);
                  Map<String, dynamic> json = await futureMap;
                  // print(await futureMap);
                  List<dynamic> jsonAdvices = json['body']['data']['advices'];
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
                      builder: (context) => BotanistVisitAdvices(
                        visit: visit,
                        advices: advices,
                        guard: guard,
                      ),
                    ),
                  );
                },
                label: 'Conseils de Botanistes',
                textColor: textColor,
                buttonColor: Colors.white,
                border: true,
                icon: LucideIcons.flower2,
              ),
              SizedBox(height: 30),
              Divider(
                color: Colors.grey,
                height: 20,
              ),
              SizedBox(height: 30),
              Text(
                'Commentaire',
                style: ArosajeTextStyle.titleFormTextStyle,
              ),
              SizedBox(height: 5),
              Text(
                visit.comment ?? "Aucun commentaire",
                style: ArosajeTextStyle.contentSecondaryTextStyle,
              ),
              SizedBox(height: 30),
              _buildPlant(),
            ],
          ),
        ),
      ),
    );
  }

  _buildPlant() {
    return Column(
      children: [
        for (var i = 0; i < plantsVisit.length; i++) _plantItem(plantsVisit[i]),
      ],
    );
  }

  _plantItem(plant) {
    // print(plant);
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      height: 85,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(plant.plantInfo.name,
                    style: ArosajeTextStyle.titleFormTextStyle),
                Text(plant.plantInfo.plantType,
                    style: ArosajeTextStyle.labelFormTextStyle),
              ],
            ),
          ),
          Container(
            // width: 145,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 66,
                height: 66,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'http://${DataApi.getHost()}:2000/uploads/${plant.image}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
