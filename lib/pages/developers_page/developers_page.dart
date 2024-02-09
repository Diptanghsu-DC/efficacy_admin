import 'dart:convert';

import 'package:efficacy_admin/pages/club/utils/create_edit_club_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer {
  final String name;
  final String image;
  final String github;
  final String linkedin;

  Developer(
      {required this.name,
      required this.image,
      required this.github,
      required this.linkedin});
}

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({super.key});

  static const String routeName = '/developersPage';

  @override
  DevelopersPageState createState() => DevelopersPageState();
}

class DevelopersPageState extends State<DevelopersPage> {
  List<Developer> developers = [];
  late List<bool> iconVisibility;

  @override
  void initState() {
    super.initState();
    loadDevelopers();
  }

  Future<void> loadDevelopers() async {
    String jsonString =
        await rootBundle.loadString('assets/developers_data/developers.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      developers = jsonList
          .map((e) => Developer(
                name: e['name'],
                image: e['image'],
                github: e['github'],
                linkedin: e['linkedin'],
              ))
          .toList();
      iconVisibility = List<bool>.filled(developers.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double cardImageSize = width * 0.35;
    double cardImageSizeSmall = width * 0.20;
    double cardSpacing = width * 0.025;
    double iconSize = width * 0.08;
    double cardWidth = width * 0.35;
    double cardHeight = width * 0.65;
    double cardSizeLarge = width * 0.7;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/efficacy_admin_logo.png"),
        ),
        centerTitle: true,
        title: const Text(
          'Developers',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Developed by Google Developer Student Clubs,",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Text(
              "National Intitute of Technology, Silchar.",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: developers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: cardSpacing,
                  mainAxisSpacing: cardSpacing,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        iconVisibility[index] = !iconVisibility[index];
                      });
                    },
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: iconVisibility[index]
                                ? cardImageSizeSmall
                                : cardImageSize,
                            height: iconVisibility[index]
                                ? cardImageSizeSmall
                                : cardImageSize,
                            decoration: BoxDecoration(
                              shape: iconVisibility[index]
                                  ? BoxShape.circle
                                  : BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(developers[index].image),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(developers[index].name),
                          const SizedBox(height: 10),
                          if (iconVisibility[index]) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.github,
                                  ),
                                  onPressed: () {
                                    launch(developers[index].github);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.linkedin,
                                  ),
                                  onPressed: () {
                                    launch(developers[index].linkedin);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
