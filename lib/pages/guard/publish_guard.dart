import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:a_rosa_je/widgets/widgets.dart';

class PublishGuard extends StatefulWidget {
  const PublishGuard({super.key});

  @override
  State<PublishGuard> createState() => _PublishGuardState();
}

class _PublishGuardState extends State<PublishGuard> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text('Date de début:', style: ArosajeTextStyle.labelFormTextStyle),
            CustomTextField(
              color: textColor,
              hintText: "Entrez une date",
              onSaved: (value) => _startDate = DateTime.parse(value ?? ''),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            Text('Date de fin:', style: ArosajeTextStyle.labelFormTextStyle),
            CustomTextField(
              color: textColor,
              hintText: "Entrez une date",
              onSaved: (value) => _endDate = DateTime.parse(value ?? ''),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
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
              onSaved: (value) => _endDate = DateTime.parse(value ?? ''),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            Text('Code postal:', style: ArosajeTextStyle.labelFormTextStyle),
            CustomTextField(
              color: textColor,
              hintText: "CP",
              onSaved: (value) => _endDate = DateTime.parse(value ?? ''),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            Text('Ville:', style: ArosajeTextStyle.labelFormTextStyle),
            CustomTextField(
              color: textColor,
              hintText: "Mtp",
              onSaved: (value) => _endDate = DateTime.parse(value ?? ''),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
          ],
        ),
      ),
    );
  }
}
