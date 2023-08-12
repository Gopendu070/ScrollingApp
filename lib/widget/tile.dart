import 'package:flutter/material.dart';
import 'package:scroll/utils/Utils.dart';

class Tile extends StatelessWidget {
  String name;
  String level;
  Tile({required this.level, required this.name});

  @override
  Widget build(BuildContext context) {
    Color tileColor(String level) {
      switch (level) {
        case 'Basic':
          return Color.fromARGB(255, 252, 199, 7);
          break;
        case 'Intermediate':
          return Color.fromARGB(255, 246, 146, 15);
        case 'Advanced':
          return Colors.greenAccent;
          break;
        default:
          return Colors.blueGrey;
          break;
      }
    }

    return Container(
      width: 150,
      child: Card(
        elevation: 6,
        color: tileColor(level),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                level,
                style: Utils.lStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  name,
                  style: Utils.nStyle,
                ),
              ),
              SizedBox(height: 12)
            ],
          ),
        ),
      ),
    );
  }
}
