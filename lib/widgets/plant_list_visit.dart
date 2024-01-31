import 'package:a_rosa_je/models/plant.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PlantListVisit extends StatefulWidget {
  const PlantListVisit({super.key, required this.plants});
  final List<Plant> plants;

  @override
  State<PlantListVisit> createState() => _PlantListVisitState();
}

class _PlantListVisitState extends State<PlantListVisit> {
  late List<Plant> plants = [];

  @override
  void initState() {
    super.initState();
    plants = widget.plants;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plants.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final plant = plants[index];
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(plant.name,
                        style: ArosajeTextStyle.titleFormTextStyle),
                    Text(plant.plantType,
                        style: ArosajeTextStyle.labelFormTextStyle),
                  ],
                ),
              ),
              Container(
                width: 150,
                child: CustomButton(
                  onPressed: () => {},
                  label: 'Ajouter photo',
                  buttonColor: primaryColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
