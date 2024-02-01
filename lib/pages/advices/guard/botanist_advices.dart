import 'dart:convert';

import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/pages/advices/guard/new_advice.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/services/user.dart';

class BotanistGuardAdvices extends StatefulWidget {
  final Guard guard;
  final List<Advice> advices;

  const BotanistGuardAdvices(
      {super.key, required this.guard, required this.advices});

  @override
  State<BotanistGuardAdvices> createState() => _BotanistAdvicesState();
}

class _BotanistAdvicesState extends State<BotanistGuardAdvices> {
  late List<Advice> advices;
  late Guard guard;
  late Map<String, dynamic> json;
  bool isBotanist = false;

  @override
  void initState() {
    guard = widget.guard;
    advices = widget.advices;
    // print(advices.length);
    // print(advices);
    super.initState();
    getUserPreference();
  }

  getUserPreference() async {
    UserService userService = UserService();
    String? jsonString = await userService.getUserPreference('user');
    if (jsonString == null) {
      return;
    }
    Map<String, dynamic> userPreference = jsonDecode(jsonString);
    if (userPreference['role'] == 'botanist') {
      setState(() {
        isBotanist = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          widget.guard.startDate.day.toString() +
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
                      builder: (context) => NewGuardAdvice(
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
        dataApi.getGuardAdvices(context, guard.id);
    Map<String, dynamic> json = await futureMap;
    List<dynamic> jsonAdvices = json['body']['data']['advices'];
    for (var advice in jsonAdvices) {
      advices.add(Advice.fromJson(advice));
    }
    setState(() {});
  }
}
