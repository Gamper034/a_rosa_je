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
    // print('set');
  }

  @override
  void didUpdateWidget(covariant SearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print('update');
    if (widget.selectedPlantTypeList != oldWidget.selectedPlantTypeList) {
      setGuardList();
    }
  }

  void setGuardList() async {
    DataApi dataApi = DataApi();

    Future<Map<String, dynamic>> futureMap = dataApi.getGuardList(
        widget.selectedPlantTypeList, widget.selectedVille);
    json = await futureMap;
    // print(json);
    setState(() {
      guards = json['body']['data']['guards']
          .map<Guard>((guard) => Guard.fromJson(guard))
          .toList();
    });
  }

  // Guard guard = Guard.fromJson(getGuardList());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: 30),
        child: Column(
          children: [
            //for each guard in guards we call the guardCard widget

            for (var guard in guards)
              GuardCard(guard: guard, myGuards: false, byCurrentUser: false)
          ],
        ),
      ),
    );
  }
}
