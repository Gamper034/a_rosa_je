import 'package:a_rosa_je/theme/color.dart';
import 'package:a_rosa_je/theme/textstyle.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyGuards extends StatefulWidget {
  const MyGuards({super.key});

  @override
  State<MyGuards> createState() => _MyGuardsState();
}

class _MyGuardsState extends State<MyGuards> {
  bool isDoneGuards = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () => {
                        setState(() {
                          isDoneGuards = true;
                        })
                      },
                      label: "Effectuées",
                      buttonColor: isDoneGuards ? primaryColor : secondaryColor,
                      textColor: isDoneGuards ? Colors.white : textColor,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      onPressed: () => {
                        setState(() {
                          isDoneGuards = false;
                        })
                      },
                      label: "Demandées",
                      buttonColor: isDoneGuards ? secondaryColor : primaryColor,
                      textColor: isDoneGuards ? textColor : Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey,
                height: 20,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
