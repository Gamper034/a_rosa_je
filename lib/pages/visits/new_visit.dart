import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/plant.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/widgets.dart';

class NewVisit extends StatefulWidget {
  final Guard guard;
  const NewVisit({super.key, required this.guard});

  @override
  State<NewVisit> createState() => _NewVisitState();
}

class _NewVisitState extends State<NewVisit> {
  late Guard guard = widget.guard;
  late List<Plant> plants = widget.guard.plants;
  String? _visitDate;
  final _visitDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // print(widget.guard);
    guard = widget.guard;
    // print(advices.length);
    // print(advices);
    super.initState();
    plants = widget.guard.plants;
    print(plants);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Ajouter une visite',
          style: ArosajeTextStyle.AppBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                Text('Date:', style: ArosajeTextStyle.contentTextStyle),
                CustomTextField(
                  controller: _visitDateController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Colors
                                .black, // Couleur principale pour le DatePicker
                            hintColor: Colors
                                .black, // Couleur d'accent pour le DatePicker
                            colorScheme: ColorScheme.light(
                              primary: Colors.black,
                              secondary:
                                  primaryColor, // Utilisé pour définir la couleur du bouton OK
                            ),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme
                                    .primary), // Utilisé pour les styles de bouton
                            dialogBackgroundColor: Colors
                                .white, // Couleur de fond pour le DatePicker
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      _visitDateController.text =
                          DateFormat('dd-MM-yyyy').format(picked);
                    }
                  },
                  color: textColor,
                  hintText: "Entrez une date",
                  onSaved: (value) => _visitDate = value,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                SizedBox(height: 30),
                PlantListVisit(
                  plants: plants,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
