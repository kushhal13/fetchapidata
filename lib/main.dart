import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://swapi.co/api/people/";

  List<Result> resultList = new List();

  final dio = Dio();

  void _getMoreData() async {
    final response = await dio.get(url);

    url = response.data['next'];
    for (int i = 0; i < response.data['results'].length; i++) {
      var resultObject = response.data['results'][i];

      List<String> filmList = new List();
      List<String> vechicleList = new List();
      List<String> starshipList = new List();

      // retriving array data
      var films = resultObject['films'];
      var vechicles = resultObject['species'];
      var starships = resultObject['starships'];

      films.forEach((film) {
        filmList.add(film);
      });

      vechicles.forEach((vechicle) {
        vechicleList.add(vechicle);
      });

      starships.forEach((starship) {
        starshipList.add(starship);
      });

      Result result = Result(
        name: resultObject['name'],
        height: resultObject['height'],
        haircolor: resultObject['hair_color'],
        skincolor: resultObject['skin_color'],
        eyecolor: resultObject['eye_color'],
        birthyear: resultObject['birth_year'],
        gender: resultObject['gender'],
        homeworld: resultObject['homeworld'],
        mass: resultObject['mass'],
        films: filmList,
        vechicles: vechicleList,
        starships: starshipList,
      );

      resultList.add(result);
    }

    setState(() {});
  }

  @override
  void initState() {
    _getMoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: resultList.isNotEmpty
          ? ListView.builder(
              itemCount: resultList.length,
              itemBuilder: (context, index) {
                Result item = resultList[index];
                return Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.gender),
                    leading: Text(item.mass),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Result {
  String name;
  String height;
  String mass;
  String haircolor;
  String skincolor;
  String birthyear;
  String eyecolor;
  String gender;
  String homeworld;
  List<String> films;
  List<String> species;
  List<String> vechicles;
  List<String> starships;
  String created;
  String edited;
  String url;
  Result(
      {this.name,
      this.height,
      this.mass,
      this.haircolor,
      this.skincolor,
      this.eyecolor,
      this.birthyear,
      this.gender,
      this.homeworld,
      this.films,
      this.species,
      this.vechicles,
      this.starships,
      this.created,
      this.edited,
      this.url});
}
