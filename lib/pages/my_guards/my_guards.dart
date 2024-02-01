import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/widgets/card-guard.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyGuards extends StatefulWidget {
  const MyGuards({super.key});

  @override
  State<MyGuards> createState() => _MyGuardsState();
}

class _MyGuardsState extends State<MyGuards> {
  bool guardsRequested = false;

  @override
  void initState() {
    super.initState();
    getGuardList(guardsRequested);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () => {
                        setState(() {
                          guardsRequested = false;
                          getGuardList(guardsRequested);
                        })
                      },
                      label: "Postulées",
                      buttonColor:
                          guardsRequested ? secondaryColor : primaryColor,
                      textColor: guardsRequested ? textColor : Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      onPressed: () => {
                        setState(() {
                          guardsRequested = true;
                          getGuardList(guardsRequested);
                        })
                      },
                      label: "Publiées",
                      buttonColor:
                          guardsRequested ? primaryColor : secondaryColor,
                      textColor: guardsRequested ? Colors.white : textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey,
                height: 20,
              ),
              SizedBox(height: 10),
              build_cards(context),
            ],
          ),
        ),
      ),
    );
  }

//Fonction Appel des guards
  late Map<String, dynamic> json;
  late List<Guard> guards = [];

  Future<List<Guard>> getGuardList(guardsRequested) async {
    String guarType = guardsRequested ? 'guardsRequested' : 'guardsMade';
    DataApi dataApi = DataApi();

    Future<Map<String, dynamic>> futureMap = dataApi.getOwnerGuards();
    json = await futureMap;
    // print(json);

    List<Guard> guards = json['body']['data']['$guarType']
        .map<Guard>((guard) => Guard.fromJson(guard))
        .toList();

    return guards;
  }

  // Widget build_cards(BuildContext context) {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: guards.length,
  //       itemBuilder: (context, index) {
  //         return GuardCard(guard: guards[index]);
  //       },
  //     ),
  //   );
  // }

  Widget build_cards(BuildContext context) {
    bool byCurrentUser = true;
    if (guardsRequested == false) byCurrentUser = false;
    return FutureBuilder<List<Guard>>(
      future: getGuardList(guardsRequested),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          // Vérifiez que snapshot.data n'est pas null avant d'y accéder
          List<Guard> guards = snapshot.data ?? [];
          if (guards.isEmpty) {
            return byCurrentUser
                ? Text(
                    'Vous n\'avez pas encore publié à une garde.',
                    style: TextStyle(color: textColor),
                  )
                : Text(
                    'Vous n\'avez pas encore postulé à une garde.',
                    style: TextStyle(color: textColor),
                  );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: guards.length,
                itemBuilder: (context, index) {
                  return GuardCard(
                      guard: guards[index],
                      myGuards: true,
                      byCurrentUser: byCurrentUser);
                },
              ),
            );
          }
        }
      },
    );
  }
}
