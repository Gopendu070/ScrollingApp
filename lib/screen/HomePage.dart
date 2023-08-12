import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scroll/widget/tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, String>> finalData = [];
  @override
  void initState() {
    fetchJsonData();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  bool reverseList = false;
  @override
  Widget build(BuildContext context) {
    var WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          title: const Text('Athlete Details'),
          backgroundColor: Color.fromARGB(162, 242, 185, 245),
        ),
        floatingActionButtonLocation: reverseList
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(201, 233, 189, 236),
          onPressed: () {
            if (reverseList == true) {
              reverseList = false;
            } else {
              reverseList = true;
            }
            setState(() {});
            showToast();
          },
          child: Icon(Icons.swap_horiz),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: WIDTH * .3,
              width: double.infinity,
              child: Scrollbar(
                thickness: 7,
                radius: Radius.circular(8),
                child: ListView.builder(
                  reverse: reverseList,
                  itemCount: finalData.length,
                  itemExtent: WIDTH * 0.4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Tile(
                      level: finalData[index]['level']!,
                      name: finalData[index]['name']!,
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Reversed..',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.purpleAccent,
        fontSize: 18);
  }

  Future<void> fetchJsonData() async {
    final response = await rootBundle.loadString('lib/asset/athlete.json');
    final jsonData = await jsonDecode(response);
    List<dynamic> athlete = jsonData as List;

    organizeList(athlete);
    setState(() {});
  }

  void organizeList(List<dynamic> player) {
    Map<String, List<String>> map = {
      'Basic': [],
      'Intermediate': [],
      'Advanced': [],
    };

    for (int i = 0; i < player.length; i++) {
      String PlayerLevel = player[i]['level'];
      String PlayerName = player[i]['name'];

      if (map.containsKey(PlayerLevel)) {
        map[PlayerLevel]!.add(PlayerName);
      }
    }
    // print(map);
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map.values.elementAt(i).length; j++) {
        finalData.add({
          'name': map.values.elementAt(i).elementAt(j),
          'level': map.keys.elementAt(i)
        });
      }
    }
    print(finalData);
  }
}
