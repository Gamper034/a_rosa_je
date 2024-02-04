import 'dart:convert';
import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/pages/advices/visit/new_visit_advice.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BotanistVisitAdvices extends StatefulWidget {
  final Visit visit;
  final List<Advice> advices;
  final Guard guard;
  final bool isBotanist;

  const BotanistVisitAdvices(
      {super.key,
      required this.visit,
      required this.advices,
      required this.guard,
      required this.isBotanist});

  @override
  State<BotanistVisitAdvices> createState() => _BotanistAdvicesState();
}

class _BotanistAdvicesState extends State<BotanistVisitAdvices> {
  late List<Advice> advices;
  late Visit visit;
  late Guard guard;
  late Map<String, dynamic> json;
  late bool isBotanist;

  @override
  void initState() {
    visit = widget.visit;
    advices = widget.advices;
    guard = widget.guard;
    isBotanist = widget.isBotanist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var day = visit.date.day == 1 ? "${visit.date.day}er" : visit.date.day;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Conseils de Botanistes',
          style: ArosajeTextStyle.AppBarTextStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          guard.startDate.day.toString() +
                              " " +
                              GuardService
                                  .monthNames[guard.startDate.month - 1] +
                              " - " +
                              guard.endDate.day.toString() +
                              " " +
                              GuardService.monthNames[guard.endDate.month - 1],
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
            Text(
                'Visite du ${day} ${GuardService.fullMonthNames[visit.date.month - 1]}',
                style: ArosajeTextStyle.smallLightTextStyle),
            SizedBox(height: 25),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            if (isBotanist) SizedBox(height: 25),
            if (isBotanist)
              CustomButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewVisitAdvice(
                        visit: visit,
                        guard: guard,
                      ),
                    ),
                  ).then(
                    (_) => _getAdvices(),
                  )
                },
                label: 'Donner un conseil',
                buttonColor: primaryColor,
                textColor: Colors.white,
              ),
            SizedBox(height: 25),
            Expanded(
              child: advices.length > 0 ? _AdvicesList() : _noAdvices(),
            )
          ],
        ),
      ),
    );
  }

  _noAdvices() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Align(
        alignment: Alignment.center,
        child: Text('Aucun conseil pour le moment.',
            style: ArosajeTextStyle.regularGreyTextStyle),
      ),
    );
  }

  _AdvicesList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: advices.length,
      itemBuilder: (context, index) {
        String botanistName = advices[index].user.firstname +
            " " +
            advices[index].user.lastname.substring(0, 1) +
            ".";
        return _AdviceItem(
            botanistName, advices[index].user.avatar, advices[index].content);
      },
    );
  }

  _AdviceItem(String botanistName, String bontanistAvatar, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.0,
                backgroundImage: NetworkImage(bontanistAvatar),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 10),
              Text(
                botanistName,
                style: ArosajeTextStyle.contentTextStyle,
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              content,
              style: ArosajeTextStyle.contentTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  _getAdvices() async {
    advices = [];
    DataApi dataApi = DataApi();

    Future<Map<String, dynamic>> futureMap =
        dataApi.getVisitAdvices(context, visit.id);
    Map<String, dynamic> json = await futureMap;
    List<dynamic> jsonAdvices = json['body']['data']['advices'];
    for (var advice in jsonAdvices) {
      advices.add(Advice.fromJson(advice));
    }
    setState(() {});
  }
}
