import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GuardCard extends StatelessWidget {
  const GuardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.33,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      child: Stack(children: [
                        Container(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                'assets/images/placeholders/plant.jpg',
                                fit: BoxFit.cover,
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Container(
                                    color: Colors.white,
                                    height: 30,
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(LucideIcons.flower2),
                                        Text("5 plantes")
                                      ],
                                    )),
                              )),
                        ),
                      ])))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage(
                            'assets/images/placeholders/profile.jpg'),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Emmanuel M.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '10 DEC - 12 DEC',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              'Juvignac 34990',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
