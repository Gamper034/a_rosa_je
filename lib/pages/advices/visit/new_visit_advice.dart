import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/services/guard.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NewVisitAdvice extends StatefulWidget {
  final Visit visit;
  final Guard guard;
  const NewVisitAdvice({super.key, required this.visit, required this.guard});

  @override
  State<NewVisitAdvice> createState() => _NewAdviceState();
}

class _NewAdviceState extends State<NewVisitAdvice> {
  final _formKey = GlobalKey<FormState>();
  String? _content;
  late Visit visit;

  @override
  void initState() {
    visit = widget.visit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var day = visit.date.day == 1 ? "${visit.date.day}er" : visit.date.day;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Donner un conseil',
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
                              backgroundImage:
                                  NetworkImage(widget.guard.owner.avatar),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.guard.owner.firstname +
                                  " " +
                                  widget.guard.owner.lastname.substring(0, 1) +
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
                                  GuardService.monthNames[
                                      widget.guard.startDate.month - 1] +
                                  " - " +
                                  widget.guard.endDate.day.toString() +
                                  " " +
                                  GuardService.monthNames[
                                      widget.guard.endDate.month - 1],
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.guard.city + " " + widget.guard.zipCode,
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
                Text(
                    'Visite du ${day} ${GuardService.fullMonthNames[visit.date.month - 1]}',
                    style: ArosajeTextStyle.titleLightTextStyle),
                SizedBox(height: 25),
                Divider(
                  color: Colors.grey,
                  height: 20,
                ),
                SizedBox(height: 25),
                CustomTextField(
                  color: textColor,
                  minLines: 10,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  hintText: "Ajoutez votre conseil ici.",
                  onSaved: (value) => _content = value,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Veuillez ajouter votre conseil.'
                      : null,
                ),
                SizedBox(height: 25),
                CustomButton(
                  onPressed: () {
                    _submit();
                  },
                  label: 'Publier le conseil',
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // print(_content);
      // print(widget.guard.id);
      _dialogConfirm(context);
    }
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

  _dialogConfirm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: ToastConfirm(
              icon: LucideIcons.helpCircle,
              title: "Publier le conseil",
              content:
                  "Êtes-vous sûr de vouloir publier ce conseil ? Vous ne pourrez plus le modifier.",
              onPressedConfirm: () async {
                String content = _content ?? '';
                String visitId = widget.visit.id;
                DataApi dataApi = DataApi();
                var publishVisitAdvice =
                    await dataApi.publishVisitAdvice(visitId, content);
                // print('publishGuardAdvice: $publishGuardAdvice.toString()');
                Navigator.of(context).pop();

                if (publishVisitAdvice['statusCode'] == 201) {
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
              title: "Conseil publié",
              content: "Votre conseil a été publié.",
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
}
