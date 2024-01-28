import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardPlant extends StatelessWidget {
  const CardPlant({super.key, required this.plant});
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/placeholders/plant.jpg'),
                // image: NetworkImage(
                //   'http://localhost:2000/uploads/${plant.image}',
                // ),
              ),
            ),
          ),

          SizedBox(width: 10), // Ajoutez un espace entre l'image et le texte
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plant.name, // Remplacez par votre titre
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                plant.plantType, // Remplacez par votre description
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
