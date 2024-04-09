import 'package:evacuationapp/routepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var locationimages = [];

GlobalKey<ScaffoldState> _key = GlobalKey();

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(),
    darkTheme: ThemeData.dark(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> locations = [
    "Multi-purpose Hall (MPH)",
    "Indoor Sports Hall (ISH)",
    "Auditorium",
    "Info Hub",
    "Staff room",
    "Robotics Room",
    "SST Inc Room",
    "Lecture Theatre (LT)",
    "Seminar Room (SR)",
    "Learning Oasis 1 (LO1)",
    "Learning Oasis 2 (LO2)",
  ];

  var imageheaders = {
    "Multi-purpose Hall (MPH)": "mph.jpeg",
    "Indoor Sports Hall (ISH)": "ish.jpeg",
    "Auditorium": "",
    "Info Hub": "",
    "Staff room": "",
    "Robotics Room": "",
    "SST Inc Room": "",
    "Lecture Theatre (LT)": "",
    "Seminar Room (SR)": "",
    "Learning Oasis 1 (LO1)": "",
    "Learning Oasis 2 (LO2)": "",
  };

  final List<String> videos = [
    "mph.mov",
  ];

  List<String> filteredLocations = [];

  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(
        milliseconds: 1000,
      ),
    );

    setState(
      () {
        filteredLocations = locations
            .where((element) => element
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
        isLoading = false;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                DrawerHeader(
                  child: Text(
                    "EvacuationSST",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Text("Created by"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  """
Luke Yeo
Ayaan Jain
Ethan Phua
""",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          icon: Icon(Icons.info),
        ),
        /*title: Text(
          "EvacuationSST",
        ),
      ),*/
        title: Column(
          children: [
            Text(
              "EvacuationSST",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(
            50,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : ListView.builder(
                        itemCount: filteredLocations.length,
                        itemBuilder: (context, index) {
                          if (imageheaders[index] != "") {
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) {
                                        return EvacuationPage(
                                          token: locations[index],
                                          filename: videos[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          "assets/images/${imageheaders[filteredLocations[index]]}",
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Flexible(
                                        child: Text(
                                          filteredLocations[index],
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 1,
                            );
                          }
                        },
                      ),
              ),
              /*ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) {
                                return EvacuationPage(
                                  token: locations[index],
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  "https://media.printables.com/media/prints/652695/images/5147802_72f5f8ab-aec1-4a98-aec6-b84da54b6103_99d0b162-b6a1-4c0a-b966-488e12d036ba/thumbs/inside/1280x960/jpg/josh_hutcherson_whistlelithograph.webp",
                                  height: 100,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                locations[index],
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: locations.length,
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
