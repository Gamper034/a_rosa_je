import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/pages/guard_details/guard_candidatures.dart';
import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/pages/advices/guard/botanist_guard_advices.dart';
import 'package:a_rosa_je/pages/visits/guard_visits.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/services/user.dart';
import 'package:a_rosa_je/widgets/status_badge_guard/status_badge.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/models/guard.dart';

import '../../theme/theme.dart';

class GuardDetails extends StatefulWidget {
  const GuardDetails({super.key, required this.guard, required this.user});
  final Guard guard;
  final User user;

  @override
  State<GuardDetails> createState() => _GuardDetailsState();
}

class _GuardDetailsState extends State<GuardDetails> {
  List<Advice> advices = [];
  late List<Visit> visitsList;
  late List<Visit> visits;
  late User user;

  late Map<String, dynamic> json;
  Guard? guard;
  GuardService guardService = GuardService();
  late GuardStatus status;
  DataApi dataApi = DataApi();

  @override
  void initState() {
    user = widget.user;
    // print(user.id);
    super.initState();
    setGuard();
  }

  void setGuard() async {
    Future<Map<String, dynamic>> futureMap = dataApi.getGuard(widget.guard.id);
    json = await futureMap;
    setState(() {
      guard = Guard.fromJson(json['body']['data']['guard']);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (guard == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );
    } else {
      status = guardService.getStatus(guard!);
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
                        'http://${DataApi.getHost()}:2000/uploads/${guard!.plants[0].image}',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: StatusBadge.getBadgeStatus(status),
                          ),
                          if (status == GuardStatus.enCours ||
                              status == GuardStatus.enAttente)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    guard!.startDate.day.toString() +
                                        " " +
                                        GuardService.monthNames[
                                            guard!.startDate.month - 1] +
                                        " - " +
                                        guard!.endDate.day.toString() +
                                        " " +
                                        GuardService.monthNames[
                                            guard!.endDate.month - 1],
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    guard!.city + " " + guard!.zipCode,
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
                      //Badge de validation
                      SizedBox(height: 10),
                      if (status != GuardStatus.enCours &&
                          status != GuardStatus.enAttente)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16.0,
                                    backgroundImage:
                                        NetworkImage(guard!.owner.avatar),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    guard!.owner.firstname +
                                        " " +
                                        guard!.owner.lastname.substring(0, 1) +
                                        ".",
                                    style: TextStyle(
                                        color: textColor, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    guard!.startDate.day.toString() +
                                        " " +
                                        GuardService.monthNames[
                                            guard!.startDate.month - 1] +
                                        " - " +
                                        guard!.endDate.day.toString() +
                                        " " +
                                        GuardService.monthNames[
                                            guard!.endDate.month - 1],
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    guard!.city + " " + guard!.zipCode,
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
                      if (status == GuardStatus.enCours &&
                          guard!.guardian != null)
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Text(
                                "Gardien :",
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      guard!.guardian!.firstname +
                                          " " +
                                          guard!.guardian!.lastname
                                              .substring(0, 1) +
                                          ".",
                                      style:
                                          ArosajeTextStyle.labelFormTextStyle,
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 16.0,
                                      backgroundImage:
                                          NetworkImage(guard!.guardian!.avatar),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (status != GuardStatus.enAttente &&
                          status != GuardStatus.aVenir &&
                          guard!.guardian != null)
                        Column(
                          children: [
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CustomButton(
                                      onPressed: () async {
                                        visits = [];
                                        DataApi dataApi = DataApi();

                                        Future<Map<String, dynamic>> futureMap =
                                            dataApi.getGuardVisits(
                                                context, guard!.id);
                                        Map<String, dynamic> json =
                                            await futureMap;
                                        // print(json);
                                        List<dynamic> jsonVisits =
                                            json['body']['data']['visits'];
                                        // print(jsonVisits);
                                        // visits = jsonVisits
                                        //     .map((visit) => Visit.fromJson(visit))
                                        //     .toList();

                                        if (jsonVisits != [])
                                          for (var visit in jsonVisits) {
                                            visits.add(Visit.fromJson(visit));
                                          }
                                        var isGuardianOfGuard =
                                            await GuardService()
                                                .isUserConnectedGuardianOf(
                                                    guard!);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GuardVisitList(
                                              guard: guard!,
                                              visits: visits,
                                              isGuardianOfGuard:
                                                  isGuardianOfGuard,
                                            ),
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
                          ],
                        ),
                      if ((status == GuardStatus.aVenir ||
                              (status == GuardStatus.enCours &&
                                  guard!.guardian == null)) &&
                          guard!.owner.id != user.id)
                        Column(
                          children: [
                            SizedBox(height: 20),
                            CustomButton(
                              onPressed: () {
                                _dialogConfirm(context);
                                // dataApi.applyToGuard(guard!.id);
                                setState(() {
                                  setGuard();
                                  status = guardService.getStatus(guard!);
                                });
                              },
                              label: 'Postuler',
                              textColor: Colors.white,
                              buttonColor: primaryColor,
                            ),
                          ],
                        ),
                      if ((status == GuardStatus.enAttente ||
                              status == GuardStatus.enCours) &&
                          guard!.owner.id == user.id &&
                          guard!.guardian == null)
                        Column(
                          children: [
                            SizedBox(height: 20),
                            CustomButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GuardCandidature(guard: guard!),
                                  ),
                                );
                                setState(() {
                                  setGuard();
                                  status = guardService.getStatus(guard!);
                                });
                              },
                              label: 'Candidatures',
                              textColor: Colors.white,
                              buttonColor: primaryColor,
                              border: true,
                            ),
                          ],
                        ),
                      SizedBox(height: 20),
                      CustomButton(
                        onPressed: () async {
                          advices = [];
                          DataApi dataApi = DataApi();

                          Future<Map<String, dynamic>> futureMap =
                              dataApi.getGuardAdvices(context, guard!.id);
                          Map<String, dynamic> json = await futureMap;
                          // print(await futureMap);
                          List<dynamic> jsonAdvices =
                              json['body']['data']['advices'];
                          // print(jsonAdvices);
                          // advices = jsonAdvices
                          //     .map((advice) => Advice.fromJson(advice))
                          //     .toList();
                          for (var advice in jsonAdvices) {
                            advices.add(Advice.fromJson(advice));
                          }

                          //Récupération des informations de l'utilisateur connecté
                          var isBotanist = await UserService().isBotanist();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BotanistGuardAdvices(
                                  guard: guard!,
                                  advices: advices,
                                  isBotanist: isBotanist),
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
                          for (var plant in guard!.plants)
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

  _dialogConfirm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: ToastConfirm(
              icon: LucideIcons.helpCircle,
              title: "Postuler pour cette garde",
              content: "Êtes-vous sûr de vouloir postuler pour cette garde ?",
              onPressedConfirm: () async {
                var applyGuard = await dataApi.applyToGuard(guard!.id);
                if (applyGuard['statusCode'] == 200) {
                  _dialogDone(context);
                } else {
                  _dialogError(context);
                }
              },
              onPressedCancel: () {
                Navigator.of(context).pop();
              },
              height: 270,
            ),
          ),
        );
      },
    );
  }

  _dialogDone(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: ToastInfo(
              icon: LucideIcons.badgeCheck,
              title: "Candidature envoyée",
              content: "Votre candidature a été envoyée.",
              onPressedConfirm: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              height: 240,
              theme: "primary",
            ),
          ),
        );
      },
    );
  }

  _dialogError(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: ToastError(
              icon: LucideIcons.badgeX,
              title: "Impossible de postuler",
              content: "un problème est survenu, veuillez réessayer.",
              onPressedConfirm: () {
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // });
              },
              height: 250,
            ),
          ),
        );
      },
    );
  }
}
