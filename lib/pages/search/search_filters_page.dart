import 'package:a_rosa_je/pages/home/home_page.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
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
  final String selectedVille;

  @override
  _searchFiltersPageState createState() => _searchFiltersPageState();
}

class _searchFiltersPageState extends State<searchFiltersPage> {
  late Map<String, dynamic> json;
  late List<String> plantTypeList = [];
  late String selectedVille = widget.selectedVille;
  final TextEditingController controller = TextEditingController();
  late List<String>? selectedPlantTypeList = [];
  late List<String>? nonSelectedPlantTypeList = [];

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
    selectedPlantTypeList = widget.selectedPlantTypeList.toList();

    for (var plantType in plantTypeList) {
      if (!selectedPlantTypeList!.contains(plantType)) {
        nonSelectedPlantTypeList!.add(plantType);
      }
    }
  }

  bool isPopInProgress = false;

  List<Widget> _buildSelectedPlantTypes() {
    return [
      Container(
        alignment: Alignment.centerLeft,
        child: Text("Sélectionnés", style: ArosajeTextStyle.labelFormTextStyle),
      ),
      Container(
        child: Wrap(
          children: selectedPlantTypeList?.length == 0
              ? [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Aucun type selectionné.',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: ArosajeTextStyle.labelFormTextStyle.fontSize,
                        fontWeight:
                            ArosajeTextStyle.labelFormTextStyle.fontWeight,
                      ),
                    ),
                  ),
                ]
              : [
                  for (var plantType in selectedPlantTypeList!)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlantTypeList!.remove(plantType);
                          nonSelectedPlantTypeList!.add(plantType);
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
                              Icon(
                                LucideIcons.x,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                plantType,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ArosajeTextStyle
                                      .labelFormTextStyle.fontSize,
                                  fontWeight: ArosajeTextStyle
                                      .labelFormTextStyle.fontWeight,
                                ),
                              ),
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
        child: Text("Disponibles", style: ArosajeTextStyle.labelFormTextStyle),
      ),
      Container(
        child: Wrap(
          children: [
            for (var plantType in nonSelectedPlantTypeList!)
              GestureDetector(
                onTap: () {
                  setState(() {
                    nonSelectedPlantTypeList!.remove(plantType);
                    selectedPlantTypeList!.add(plantType);
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
                        Icon(
                          LucideIcons.plus,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(plantType,
                            style: ArosajeTextStyle.labelFormTextStyle),
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
    if (selectedPlantTypeList!.length == 0 &&
        nonSelectedPlantTypeList!.length == 0) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filtres de recherche',
                      style: ArosajeTextStyle.AppBarTextStyle),
                  IconButton(
                      icon:
                          Icon(LucideIcons.x), // Changer l'icône si nécessaire
                      onPressed: () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        selectedPlantTypeList:
                                            widget.selectedPlantTypeList,
                                        selectedVille: widget.selectedVille,
                                      )),
                            )
                          }),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Localisation",
                                style: ArosajeTextStyle.titleFormTextStyle),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: controller,
                              color: textColor,
                              hintText: "Ville",
                              onChanged: (value) {
                                setState(() {
                                  selectedVille = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Types de plantes",
                                style: ArosajeTextStyle.titleFormTextStyle),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  child: Column(
                                      children: _buildSelectedPlantTypes()),
                                ),
                                Container(
                                  child: Column(
                                      children: _buildUnselectedPlantTypes()),
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
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 40, left: 20, right: 20),
          child: CustomButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    selectedPlantTypeList: selectedPlantTypeList!,
                    selectedVille: selectedVille,
                  ),
                ),
              );
            },
            label: 'Enregistrer',
            textColor: Colors.white,
            buttonColor: primaryColor,
            icon: LucideIcons.save,
          ),
        ),
      );
    }
  }
}
