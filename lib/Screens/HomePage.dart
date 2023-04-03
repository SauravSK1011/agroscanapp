import 'dart:convert';
import 'package:agroscan/Screens/Newspage.dart';
import 'package:agroscan/Screens/Schemespage.dart';

import 'package:agroscan/Screens/prediction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

import '../firebase.dart';
import '../model/datam.dart';
import 'Searchscreen.dart';
import 'helper/news.dart';
import 'modal/artical_modal.dart';
import 'views/widget/blog_tile.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.lang});
  late String lang;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Myusers> data1;
  late Myusers pdata;

  late Position _currentPosition;
  String _city = "";
  double _temperature = 0.0;
  String _weatherIcon = "";
  String _weatherCondition = "";
  String _error = "";
  List<ArticalModel> searchnews = [];
  bool _loding = true;
  // late var ans;
  bool load = false;
  Future<String> translate(String input) async {
    final translator = GoogleTranslator();
    Translation ans = await translator.translate(input, from: 'en', to: 'mr');
    String translatedtext = ans.text;

    print("ans is ");
    print(ans);
    setState(() {
      load = true;
    });
    return translatedtext;
  }

  grtNews() async {
    News newsclass = News();
    // await newsclass.getNews();
    searchnews = newsclass.news;
    Search1 newsclass1 = Search1();
    searchnews = await newsclass1.getNews("Farmer");
    print(searchnews);
    setState(() {
      _loding = false;
    });
  }

  var permission;

  String namem = "";
  bool loadpdata = false;
  getdata() async {
    pdata = await firebaseefunc.getdata();
    // pdata = data1[0];

    namem = await translate(pdata.name);
    setState(() {
      loadpdata = true;
    });
  }

  String? _currentAddress1;

  bool load1 = false;

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress1 =
  //           '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  var cloud;
  void _getWeather() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${_currentPosition.latitude}&lon=${_currentPosition.longitude}&appid=55a2a3de9b3cdcac1093ea844488264d&units=metric";
    try {
      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> result = json.decode(response.body);
      print("result");
      print(result);

      setState(() {
        _city = result["name"];
        _temperature = result["main"]["temp"];
        print(_temperature);
        _weatherIcon = result["weather"][0]["description"];
        _weatherCondition = result["weather"][0]["main"];
        cloud = result["all"];
        load1 = true;
        translate(_weatherIcon);
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  String address = '';

  void _getLocation() async {
    print('position is');
    permission = await Geolocator.requestPermission();

    try {
      Position position = await Geolocator.getCurrentPosition(
          // forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.high);
      // _getAddressFromLatLng(position);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.latitude);
      print("position.longitude");
      print(position.longitude);
      print("position.latitude");
      print(position.latitude);

      setState(() {
        _currentPosition = position;
        address = placemarks[0].name!;
      });
      _getWeather();
    } catch (e) {
      print("eeeor" + e.toString());
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
    grtNews();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(126, 217, 87, 1),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "FARMGARD",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                loadpdata == true && load1 == true
                    ? Card(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 8,
                                  //     left: 25,
                                  //     right: 8,
                                  //   ),
                                  //   child: Text(
                                  //     "WELCOME",
                                  //     style: TextStyle(
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.black),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, top: 8, right: 8),
                                    child: Text(
                                      widget.lang == "English"
                                          ? pdata.name.toString()
                                          : namem.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                    ),
                                    child: Text(
                                      "Location: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8,
                                    ),
                                    child: Text(
                                      address,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 8,
                                    ),
                                    child: Text(
                                      widget.lang == "English"
                                          ? "Temperature: " +
                                              _temperature.toString() +
                                              "°C"
                                          : "तापमान: " +
                                              _temperature.toString() +
                                              "°C",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 8, bottom: 8),
                                    child: Text(
                                      widget.lang == "English"
                                          ? "weather: " +
                                              _weatherIcon.toString()
                                          : "हवामान: " + "ans.toString()",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const Card(),
                SizedBox(
                  height: 50,
                ),
                widget.lang == "English"
                    ? Text('Welcome',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                    : Text(
                        'नमस्कार',
                        style: DevanagariFonts.hind(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color: Colors.white,
                  child: Column(children: []),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Card()
                        ],),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'Sugercane',
                                      image: 'assets/sugercane.jpeg',
                                      model: 'assets/sugercane.tflite',
                                      lable: 'assets/sugercane.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                // Card(color: Colors.grey,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Stack(
                                //       children: [
                                //            Image.asset(
                                //             'assets/sugercane.jpeg',height: imageheight,
                                //           ),
                                        
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/sugercane.jpeg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'Corn',
                                      image: 'assets/corn.jpg',
                                      model: 'assets/corn.tflite',
                                      lable: 'assets/corn.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/corn.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'Potato',
                                      image: 'assets/potato.jpg',
                                      model: 'assets/potato.tflite',
                                      lable: 'assets/potato.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/potato.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'Soya',
                                      image: 'assets/soya.jpg',
                                      model: 'assets/soya.tflite',
                                      lable: 'assets/soya.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/soya.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'apple',
                                      image: 'assets/apple.jpg',
                                      model: 'assets/apple.tflite',
                                      lable: 'assets/apple.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/apple.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'grapes',
                                      image: 'assets/grapes.jpg',
                                      model: 'assets/grapes.tflite',
                                      lable: 'assets/grapes.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/grapes.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'casavva',
                                      image: 'assets/casavva.jpg',
                                      model: 'assets/casavva.tflite',
                                      lable: 'assets/casavva.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/casavva.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'tomato',
                                      image: 'assets/tomato.jpg',
                                      model: 'assets/Tomato1.tflite',
                                      lable: 'assets/Tomato1.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/tomato.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'rice',
                                      image: 'assets/rice.jpg',
                                      model: 'assets/rice.tflite',
                                      lable: 'assets/rice.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/rice.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  DataM data = DataM(
                                      plant: 'wheat',
                                      image: 'assets/weet.jpg',
                                      model: 'assets/wheat.tflite',
                                      lable: 'assets/wheat.txt',
                                      lang: widget.lang);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              predictionScreen(
                                                data: data,
                                              )));
                                },
                                child: const CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/weet.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: widget.lang == "English"
                                ? Text(
                                    "Treat your Crop",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "प्रक्रिया खालीलप्रमाणे",
                                    style: DevanagariFonts.hind(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/plantscan.jpg",
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Icon(
                              Icons.arrow_right_outlined,
                              size: 40,
                            ),
                            Image.asset(
                              "assets/report.png",
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Icon(
                              Icons.arrow_right_outlined,
                              size: 40,
                            ),
                            Image.asset(
                              "assets/fertilizer.jpg",
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SchemesPage(
                                        lang: widget.lang,
                                      )));
                        },
                        child: Container(
                            width: 100,
                            child: Center(
                              child: Text(
                                widget.lang == "English" ? "Schemes" : "योजना",
                                style: TextStyle(color: Colors.green),
                              ),
                            ))),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsPage(
                                        articalsnews: searchnews,
                                      )));
                        },
                        child: Container(
                            width: 100,
                            child: Center(
                              child: Text(
                                widget.lang == "English" ? "NEWS" : "बातम्या",
                                style: TextStyle(color: Colors.green),
                              ),
                            ))),
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
