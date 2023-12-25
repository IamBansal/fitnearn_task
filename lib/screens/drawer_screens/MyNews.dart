import 'package:flutter/material.dart';

import '../../providers/DatabaseProvider.dart';
import '../MainScreen.dart';
import '../../model/Recommendation.dart';

class MyNews extends StatefulWidget {
  const MyNews({super.key});

  @override
  State<MyNews> createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {

  @override
  void initState() {
    super.initState();
    getRecommendations();
  }

  Future<void> getRecommendations() async {
    final dbProvider = DatabaseProvider();
    await dbProvider.open();
    final loadedRecommendations = await dbProvider.getRecommendations();

    setState(() {
      dataList = loadedRecommendations;
    });
  }

  List<Recommendation> dataList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
                  elevation: MaterialStateProperty.all(20)),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF5271EF),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: const Text(
              'My News',
              style: TextStyle(
                  color: Color(0xFF5271EF),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          body:
          dataList.isEmpty ? const Text('No favorites', style: TextStyle(color: Color(0xFF5271EF)),) :
          RefreshIndicator(
            onRefresh: getRecommendations,
            child: ListView.builder(
              itemCount: dataList.length > 20 ? 20 : dataList.length,
              itemBuilder: (context, index) {
                return RecommendationCard(
                    Recommendation(
                        title: dataList[index].title,
                        desc: dataList[index].desc,
                        image: dataList[index].image));
              },
            ),
          ),
        ));
  }
}
