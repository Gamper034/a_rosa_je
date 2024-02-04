import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/pages/visits/new_visit.dart';
import 'package:a_rosa_je/pages/visits/visit_detail.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GuardVisitList extends StatefulWidget {
  final Guard guard;
  final List<Visit> visits;
  final bool isGuardianOfGuard;

  const GuardVisitList(
      {super.key,
      required this.guard,
      required this.visits,
      required this.isGuardianOfGuard});

  @override
  State<GuardVisitList> createState() => _BotanistAdvicesState();
}

class _BotanistAdvicesState extends State<GuardVisitList> {
  late List<Visit> visits;
  late Guard guard;
  late Map<String, dynamic> json;
  late bool isGuardianOfGuard;

  @override
  void initState() {
    guard = widget.guard;
    visits = widget.visits;
    isGuardianOfGuard = widget.isGuardianOfGuard;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Liste des visites',
          style: ArosajeTextStyle.AppBarTextStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
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
              Divider(
                color: Colors.grey,
                height: 20,
              ),
              SizedBox(height: 30),
              if (isGuardianOfGuard == true)
                CustomButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewVisit(
                          guard: guard,
                        ),
                      ),
                    ).then(
                      (_) => _getVisits(),
                    )
                  },
                  label: 'Ajouter une nouvelle visite',
                  buttonColor: primaryColor,
                  textColor: Colors.white,
                ),
              SizedBox(height: 30),
              if (visits.length > 0) _VisitsList() else _noVisit(),
            ],
          ),
        ),
      ),
    );
  }

  _noVisit() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Align(
        alignment: Alignment.center,
        child: Text('Aucune visite pour le moment.',
            style: ArosajeTextStyle.regularGreyTextStyle),
      ),
    );
  }

  _VisitsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: visits.length,
      itemBuilder: (context, index) {
        String date = visits[index].date.day.toString() +
            " " +
            GuardService.monthNames[visits[index].date.month - 1];
        String indexString = (index + 1).toString();

        return _VisitItem(date, indexString, visits[index]);
      },
    );
  }

  _VisitItem(String date, String index, Visit visit) {
    return GestureDetector(
      onTap: () async {
        DataApi dataApi = DataApi();

        Future<Map<String, dynamic>> futureMap =
            dataApi.getVisit(context, visit.id);
        Map<String, dynamic> json = await futureMap;
        // print(await futureMap);
        Map<String, dynamic> jsonVisit = json['body']['data']['visit'];
        // print(jsonVisit);
        visit = Visit.fromJson(jsonVisit);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitDetail(
              visit: visit,
              guard: guard,
            ),
          ),
        ).then(
          (_) => _getVisits(),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        child: Row(
          children: [
            Text(
              '${index}#',
              style: ArosajeTextStyle.secondarySubTitle,
            ),
            SizedBox(width: 10),
            Text(
              date,
              style: ArosajeTextStyle.titleFormTextStyle,
            )
          ],
        ),
      ),
    );
  }

  _getVisits() async {
    visits = [];
    DataApi dataApi = DataApi();

    Future<Map<String, dynamic>> futureMap =
        dataApi.getGuardVisits(context, guard.id);
    Map<String, dynamic> json = await futureMap;
    List<dynamic> jsonVisits = json['body']['data']['visits'];
    for (var visit in jsonVisits) {
      visits.add(Visit.fromJson(visit));
    }
    setState(() {});
  }
}
