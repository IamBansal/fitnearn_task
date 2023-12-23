import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnearn/LocalizationScreen.dart';
import 'package:fitnearn/LoginScreen.dart';
import 'package:fitnearn/MyNews.dart';
import 'package:fitnearn/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'DataProvider.dart';
import 'DatabaseProvider.dart';
import 'ImagePathHandler.dart';
import 'Recommendation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isVisible = false;
  String name = 'User';
  String number = '+91 9876543210';
  List<dynamic> dataList = [];
  late final DataProvider provider;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    getImage();
    _getNameNumber();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<DataProvider>(context, listen: false);
      provider.fetchData();
      dataList = provider.dataList;
    });
  }

  Future<void> getImage() async {
    String? retrievedImagePath = await ImagePathHandler.getImagePath();
    if (retrievedImagePath != null) {
      setState(() {
        _imageFile = File(retrievedImagePath);
      });
    }
  }

  Future<void> _getNameNumber() async {
    List<String>? list = await ImagePathHandler.getName();
    setState(() {
      name = list!.first;
      number = list.last;
    });
  }

  File _imageFile = File('');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF5271EF), width: 1)),
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: _imageFile != File('')
                        ? CircleAvatar(
                            backgroundImage: FileImage(_imageFile),
                            radius: 50.0,
                          )
                        : ClipOval(
                            child: Image.asset(
                            'assets/pic.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )))),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Hi, $name",
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5271EF)),
            ),
          ],
        ),
      ],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              elevation: MaterialStateProperty.all(20)),
          icon: const Icon(
            Icons.menu,
            color: Color(0xFF5271EF),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: const Text(
          'MentorX',
          style: TextStyle(
              color: Color(0xFF5271EF),
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        actions: [
          IconButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                elevation: MaterialStateProperty.all(20)),
            icon: const Icon(
              Icons.person,
              color: Color(0xFF5271EF),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
          ),
        ],
      ),
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF5271EF), width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: _imageFile != File('')
                      ? CircleAvatar(
                          backgroundImage: FileImage(_imageFile),
                          radius: 50.0,
                        )
                      : ClipOval(
                          child: Image.asset(
                          'assets/pic.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )),
                )),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Hi, $name",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(number),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 270,
              height: 3,
              color: const Color(0xFF5271EF),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.history,
                      color: Color(0xFF5271EF),
                    ),
                    title: const Text('My News'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyNews(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.save_alt_rounded,
                      color: Color(0xFF5271EF),
                    ),
                    title: const Text('Internationalization and Localization'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LocalizationScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Color(0xFF5271EF),
                    ),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.notifications,
                      color: Color(0xFF5271EF),
                    ),
                    title: const Text('Notifications'),
                    onTap: () {
                      // Handle item 3 click
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Color(0xFF5271EF),
                    ),
                    title: const Text('Settings'),
                    onTap: () {
                      // Handle item 4 click
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5271EF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29),
                    side: const BorderSide(color: Color(0xFF5271EF)),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance
                      .signOut()
                      .whenComplete(() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: dataList.length > 20 ? 20 : dataList.length,
          itemBuilder: (context, index) {
            return RecommendationCard(Recommendation(
                title: dataList[index]['title'],
                desc: dataList[index]['description'] ?? "No description",
                image: dataList[index]['urlToImage'] ?? "No url to image"));
          },
        ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    provider.fetchData();
    setState(() {
      dataList = provider.dataList;
    });
  }
}

//Custom widget
class RecommendationCard extends StatefulWidget {
  final Recommendation recommendation;

  const RecommendationCard(this.recommendation, {super.key});

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF000000), width: 1),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  toggleFavorite();
                },
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Center(
                    child: Image.network(
                      widget.recommendation.image,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Text('Failed to load image');
                      },
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Text(
                  widget.recommendation.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF5271EF)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Text(
                  widget.recommendation.desc,
                  maxLines: 9,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  Future<void> checkFavorite() async {
    final dbProvider = DatabaseProvider();
    await dbProvider.open();
    final recommendations = await dbProvider.getRecommendations();
    setState(() {
      isFavorite = recommendations
          .any((rec) => rec.title == widget.recommendation.title);
    });
  }

  Future<void> toggleFavorite() async {
    final dbProvider = DatabaseProvider();
    await dbProvider.open();

    if (isFavorite) {
      await dbProvider.removeRecommendation(widget.recommendation.title);
    } else {
      await dbProvider.addRecommendation(widget.recommendation);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }
}
