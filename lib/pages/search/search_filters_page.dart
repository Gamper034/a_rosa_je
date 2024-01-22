import 'dart:convert';

import 'package:a_rosa_je/pages/home/home_page.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class searchFiltersPage extends StatefulWidget {
  searchFiltersPage(
      {Key? key,
      required List<String> selectedPlantTypeList,
      required this.selectedVille})
      : selectedPlantTypeList = List.from(selectedPlantTypeList),
        super(key: key);

  final List<String> selectedPlantTypeList;
  final List<String> nonSelectedPlantTypeList = [];
  final String selectedVille;

  @override
  _searchFiltersPageState createState() => _searchFiltersPageState();
}

class _searchFiltersPageState extends State<searchFiltersPage> {
  late Map<String, dynamic> json;
  late List<String> plantTypeList = [];
  late String selectedVille = widget.selectedVille;
  final TextEditingController controller = TextEditingController();

  _searchFiltersPageState();

  @override
  void initState() {
    super.initState();
    setPlantTypeList();
    if (selectedVille != '') {
      controller.text = selectedVille;
    }
  }

  void setPlantTypeList() async {
    DataApi dataApi = DataApi();

    Future<Map<String, dynamic>> futureMap = dataApi.getPlantTypeList();

    json = await futureMap;
    setState(() {
      plantTypeList = (json['body'] as List<dynamic>)
          .map<String>((plantType) =>
              (plantType as Map<String, dynamic>)['name'] as String)
          .toList();
    });
    for (var plantType in plantTypeList) {
      if (!widget.selectedPlantTypeList.contains(plantType)) {
        widget.nonSelectedPlantTypeList.add(plantType);
      }
    }
  }

  bool isPopInProgress = false;

  void onPopInvoked(bool result) {
    if (!isPopInProgress) {
      isPopInProgress = true;
      Future.delayed(Duration.zero, () {
        Navigator.pop(context, widget.selectedPlantTypeList);
        isPopInProgress = false;
      });
    }
  }

  List<Widget> _buildSelectedPlantTypes() {
    return [
      Container(
        alignment: Alignment.centerLeft,
        child: Text("Sélectionnés", style: TextStyle(fontSize: 18)),
      ),
      Container(
        child: Wrap(
          children: [
            for (var plantType in widget.selectedPlantTypeList)
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedPlantTypeList.remove(plantType);
                    widget.nonSelectedPlantTypeList.add(plantType);
                  });
                },
                child: IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(LucideIcons.x, color: Colors.white),
                        SizedBox(width: 5),
                        Text(plantType, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildUnselectedPlantTypes() {
    return [
      Container(
        alignment: Alignment.centerLeft,
        child: Text("Disponibles", style: TextStyle(fontSize: 18)),
      ),
      Container(
        child: Wrap(
          children: [
            for (var plantType in widget.nonSelectedPlantTypeList)
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.nonSelectedPlantTypeList.remove(plantType);
                    widget.selectedPlantTypeList.add(plantType);
                  });
                },
                child: IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(LucideIcons.plus),
                        SizedBox(width: 5),
                        Text(plantType),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          selectedPlantTypeList: widget.selectedPlantTypeList,
                          selectedVille: selectedVille,
                        ),
                      ),
                    );
                  },
                  child: Icon(LucideIcons.check),
                ),
                Text(
                  'Filtres de recherche',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child:
                          Text("Localisation", style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Ville',
                          suffixIcon: Icon(LucideIcons.mapPin),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedVille = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Types de plantes",
                          style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Column(children: _buildSelectedPlantTypes()),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child:
                                Column(children: _buildUnselectedPlantTypes()),
                          ),
                        ],
                      ),
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
