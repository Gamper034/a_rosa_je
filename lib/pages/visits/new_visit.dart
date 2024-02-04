import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/plant.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:io';

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
  String _visitDate = '';
  final _visitDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _commentaire = '';
  List<XFile?> plantImages = [];
  List<String> plantImagesPaths = [];

  @override
  void initState() {
    // print(widget.guard);
    guard = widget.guard;
    // print(advices.length);
    // print(advices);
    plants = widget.guard.plants;
    plantImages = List.filled(plants.length, null);
    super.initState();
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
                Text('Date', style: ArosajeTextStyle.contentTextStyle),
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
                  onSaved: (value) => _visitDate = value ?? '',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                SizedBox(height: 30),
                _buildPlant(),
                SizedBox(height: 30),
                Text('Commentaire', style: ArosajeTextStyle.contentTextStyle),
                CustomTextField(
                  color: textColor,
                  minLines: 5,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  hintText: "Ajoutez votre commentaire ici.",
                  onSaved: (value) => _commentaire = value ?? '',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Veuillez ajouter votre commentaire.'
                      : null,
                ),
                SizedBox(height: 30),
                CustomButton(
                  onPressed: () {
                    _submit();
                  },
                  label: 'Ajouter une nouvelle visite',
                  buttonColor: primaryColor,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate() && !plantImages.contains(null)) {
      _formKey.currentState!.save();
      //TODO: optimiser le code pour récupérer direct les paths des images & ajout 401 dans tous les services et scroll plantes
      _dialogConfirm(context);
    } else {
      _dialogError(context);
    }
  }

  _buildPlant() {
    return Column(
      children: [
        for (var i = 0; i < plants.length; i++) _plantItem(plants[i], i),
      ],
    );
  }

  _plantItem(plant, int index) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      height: 85,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(plant.name, style: ArosajeTextStyle.titleFormTextStyle),
                Text(plant.plantType,
                    style: ArosajeTextStyle.labelFormTextStyle),
              ],
            ),
          ),
          Container(
            // width: 145,
            child: plantImages[index] == null
                ? Expanded(
                    child: CustomButton(
                      onPressed: () => _addImage(index),
                      label: 'Ajouter photo',
                      buttonColor: primaryColor,
                      textColor: Colors.white,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(plantImages[index]!.path),
                      width: 66,
                      height: 66,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _addImage(int index) async {
    final ImagePicker _picker = ImagePicker();
    final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Align(
              alignment: Alignment.center,
              child: Text('Ajouter une photo'),
            ),
            backgroundColor: Colors.white,
            children: <Widget>[
              ListTile(
                leading: Icon(LucideIcons.camera), // Icône de la caméra
                title: Text('Prendre une photo', textAlign: TextAlign.center),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(LucideIcons.image), // Icône de la caméra
                title: Text('Choisir depuis la galerie',
                    textAlign: TextAlign.center),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          );
        });

    if (source != null) {
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        // plants[index]['plantImage'] = Image.file(File(image.path));

        setState(() {
          plantImages[index] = image;
        });
      }
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
              title: "Publier la visite",
              content:
                  "Êtes-vous sûr de vouloir publier cette visite ? Vous ne pourrez plus la modifier.",
              onPressedConfirm: () async {
                plantImagesPaths =
                    plantImages.map((xfile) => xfile?.path ?? '').toList();
                var addVisit = await DataApi().addVisit(
                  context,
                  _visitDate,
                  _commentaire,
                  plantImagesPaths,
                  widget.guard.id,
                );

                Navigator.of(context).pop();

                print(addVisit['statusCode']);
                if (addVisit['statusCode'] == 201) {
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
              title: "Visite publiée",
              content: "Votre visite a été publiée.",
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
              title: "Impossible de publier",
              content: "un problème est survenu, veuillez réessayer.",
              onPressedConfirm: () {
                // WidgetsBinding.instance.addPostFrameCallback((_) {
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
