import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/widgets/card-guard.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  SearchPage(
      {super.key,
      required this.selectedPlantTypeList,
      required this.selectedVille});

  List<String> selectedPlantTypeList;
  String selectedVille;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Map<String, dynamic> json;
  late List<Guard> guards = [];

  @override
  void initState() {
    super.initState();
    setGuardList();
  }

  @override
  void didUpdateWidget(covariant SearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedPlantTypeList != oldWidget.selectedPlantTypeList) {
      setGuardList();
    }
  }

  void setGuardList() async {
    DataApi dataApi = DataApi();

    Future<Map<String, dynamic>> futureMap = dataApi.getGuardList(
        widget.selectedPlantTypeList, widget.selectedVille);
    json = await futureMap;
    setState(() {
      guards = json['body']['data']['guards']
          .map<Guard>((guard) => Guard.fromJson(guard))
          .toList();
    });
  }

  // Guard guard = Guard.fromJson(getGuardList());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, top: 30),
      child: ListView.builder(
        itemCount: guards.length,
        itemBuilder: (context, index) {
          return GuardCard(
              guard: guards[index], myGuards: false, byCurrentUser: false);
        },
      ),
    );
  }
}
