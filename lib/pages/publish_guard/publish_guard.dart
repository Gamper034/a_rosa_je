import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PublishGuard extends StatefulWidget {
  const PublishGuard({super.key});

  @override
  State<PublishGuard> createState() => _PublishGuardState();
}

class _PublishGuardState extends State<PublishGuard> {
  final _formKey = GlobalKey<FormState>();
  String? _startDate;
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  String? _endDate;
  String? _address;
  String? _zipCode;
  String? _city;
  int plantNumber = 0;
  List<Widget> plantContainers = [];

  List<String> plantTypes = [];

  @override
  void initState() {
    super.initState();
    fetchPlantTypes();
  }

  fetchPlantTypes() async {
    DataApi dataApi = DataApi();
    var result = await dataApi.getPlantsType();
    setState(() {
      plantTypes = result;
      // print(plantTypes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dates', style: ArosajeTextStyle.titleFormTextStyle),
                Divider(
                  color: primaryColor,
                ),
                SizedBox(height: 10),
                Text('Date de début:',
                    style: ArosajeTextStyle.labelFormTextStyle),
                CustomTextField(
                  controller: _startDateController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
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
                      _startDateController.text =
                          DateFormat('dd-MM-yyyy').format(picked);
                    }
                  },
                  color: textColor,
                  hintText: "Entrez une date",
                  onSaved: (value) => _startDate = value,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                Text('Date de fin:',
                    style: ArosajeTextStyle.labelFormTextStyle),
                CustomTextField(
                  controller: _endDateController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
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
                      _endDateController.text =
                          DateFormat('dd-MM-yyyy').format(picked);
                    }
                  },
                  color: textColor,
                  hintText: "Entrez une date",
                  onSaved: (value) => _endDate = value,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                SizedBox(height: 15),
                Text('Adresse', style: ArosajeTextStyle.titleFormTextStyle),
                Divider(
                  color: primaryColor,
                ),
                SizedBox(height: 10),
                Text('N° et libellé de rue:',
                    style: ArosajeTextStyle.labelFormTextStyle),
                CustomTextField(
                  color: textColor,
                  hintText: "Adresse",
                  onSaved: (value) => _address = value,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                Text('Code postal:',
                    style: ArosajeTextStyle.labelFormTextStyle),
                CustomTextField(
                  color: textColor,
                  hintText: "",
                  onSaved: (value) => _zipCode = value,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                Text('Ville:', style: ArosajeTextStyle.labelFormTextStyle),
                CustomTextField(
                  color: textColor,
                  hintText: "",
                  onSaved: (value) => _city = value,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                SizedBox(height: 15),
                Text('Plantes à garder',
                    style: ArosajeTextStyle.titleFormTextStyle),
                Divider(
                  color: primaryColor,
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    for (int i = 0; i < plantContainers.length; i++) ...[
                      _buildPlantContainer(i),
                      if (i != plantContainers.length - 1)
                        SizedBox(
                            height:
                                10), // Ajoute un espace entre les containers
                    ],
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {
                        setState(() {
                          plantContainers.add(
                              _buildPlantContainer(plantContainers.length));
                        });
                      },
                      label: 'Ajouter une plante',
                      icon: LucideIcons.flower2,
                      buttonColor: secondaryColor,
                      textColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: primaryColor,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: _submit,
                  label: 'Publier la demande de garde',
                  buttonColor: primaryColor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Sauvegarde les valeurs des champs

      GuardService guardService = GuardService();

      guardService.addGuard(
        context,
        _startDate!,
        _endDate!,
        _address!,
        _zipCode!,
        _city!,
        plants,
      );
    }
  }

  List<Map<String, dynamic>> plants = [];

  Widget _buildPlantContainer(int index) {
    if (index >= plants.length) {
      Map<String, dynamic> plant = {
        'plantName': null,
        'plantType': null,
        'plantImage': null,
        'plantImageUrl': null,
      };
      plants.add(plant);
    }

    return Container(
      width: double.infinity,
      // height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Plante n°${index + 1}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _deleteContainer(index);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom de la plante',
                          style: ArosajeTextStyle.labelFormTextStyle),
                      CustomTextField(
                        color: Colors.black,
                        hintText: "",
                        onSaved: (value) {
                          plants[index]['plantName'] = value;
                        },
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Ce champ est obligatoire'
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Catégorie',
                          style: ArosajeTextStyle.labelFormTextStyle),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 0.5, color: textColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 0.5, color: textColor),
                            ),
                          ),
                          value: plants[index]['plantType'],
                          onChanged: (value) {
                            setState(() {
                              plants[index]['plantType'] = value;
                            });
                          },
                          items: plantTypes.map((plantType) {
                            return DropdownMenuItem(
                              value: plantType,
                              child: Container(
                                width: 102,
                                child: Text(
                                  '$plantType',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            plants[index]['plantImageUrl'] != null
                ? AspectRatio(
                    aspectRatio: 21 /
                        9, // Ajustez ce ratio pour obtenir la hauteur désirée
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Ajoute des bordures arrondies
                          child: Container(
                            width: double
                                .infinity, // Utilise toute la largeur disponible
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage(plants[index]['plantImageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity, // La même largeur que l'image
                          color: Colors.white.withOpacity(
                              0.3), // Un voile blanc semi-transparent
                        ),
                        // Positioned(
                        //   top: 5.0,
                        //   right: 5.0,
                        //   child: CustomButton(
                        //     onPressed: _pickFile,
                        //     label: 'Modifier la photo',
                        //     icon: LucideIcons.camera,
                        //     buttonColor: secondaryColor,
                        //     textColor: Colors.black,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                : CustomButton(
                    onPressed: () {
                      _addImage(index);
                    },
                    label: 'Ajouter une photo',
                    icon: LucideIcons.camera,
                    buttonColor: primaryColor,
                    textColor: Colors.white,
                  ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteContainer(int index) async {
    setState(() {
      plantContainers.removeAt(index); // Supprime le container à l'index donné
      plants.removeAt(index); // Supprime la plante à l'index donné
    });
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
        plants[index]['plantImageUrl'] = image.path;
        setState(() {});
      }
    }
  }
}
