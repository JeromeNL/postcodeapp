import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:postcodeapp/postCodeAPI.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  postCodeAPI dataFromAPI = postCodeAPI();
  Map<String, String> APIData = Map();
  String postCode = '';
  String number = '';
  String street = '';
  String city = '';
  String municipality = "";
  String province = '';

  String givenPostcode = "N/A";
  String givenNumber = "N/A";

  final postcodeController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    postcodeController.dispose();
    numberController.dispose();
    super.dispose();
  }





  void fillInCorrectData() {
    setState(() {
      postCode = APIData.values.elementAt(5);
      number = APIData.values.elementAt(1);
      street = APIData.values.elementAt(2) + ", ";
      city = APIData.values.elementAt(0);
      municipality = APIData.values.elementAt(3);
      province = APIData.values.elementAt(4);
    });
  }

  void clearAllDataFromView(){
    String postCode = '';
    String number = '';
    String street = '';
    String city = '';
    String municipality = "";
    String province = '';
  }

  void givenDataNotCorrect(){
    setState(() {
       postCode = 'Postcode bestaat niet!';
       number = '';
       street = '';
       city = '';
       municipality = "";
       province = '';
    });
  }

  void copyAddress(){
    String fullAddress = "Geen Adres Gevonden :(";
    if(postCode != null){
      fullAddress = street + ", " + number + " " + postCode + " " + city + " " + municipality + " " + province;
    }

    Clipboard.setData(ClipboardData(text: fullAddress)).then((_){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Het adres is naar jouw klembord gekopieerd!")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adres Checker'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 125,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
                child: const Center(
                  child: Text(
                    "Adres Checker",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            // Share PlayStore link to a friend by 'share popup'
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Deel deze app'),
              onTap: () {
                Share.share(
                    'Ik gebruik deze geweldige app: https://www.joramkwetters.nl/');
              },
            ),
            // User goes to PlayStore, where he can leave a review.
            ListTile(
              leading: const Icon(Icons.reviews),
              title: const Text('Beoordeel ons'),
              onTap: () async {
                try {
                  {
                    StoreRedirect.redirect(
                        androidAppId: "nl.rtl.videoland.v2",
                        iOSAppId: "585027354");
                  }
                } catch (e) {}
              },
            ),
            // User goes to personal website
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Meer info'),
              onTap: () async {
                Uri url = Uri.parse("https://www.joramkwetters.nl");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw "Cannot load url";
                }
              },
            ),
            // User goes to personal Github of JeromeNL
            SizedBox(height: MediaQuery.of(context).size.height / 1.7),
            Divider(
              color: Colors.grey[900],
              height: 0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontStyle: FontStyle.italic,
                        ),
                        text: "An App by JeromeNL",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Uri url = Uri.parse("https://github.com/JeromeNL");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw "Cannot load url";
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
    child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Container(
              height: (MediaQuery.of(context).size.height / 2.5),
              width: (MediaQuery.of(context).size.width / 1.25),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                        child: TextButton.icon(
                          label: Text("Kopieren"),
                          icon: Icon(Icons.copy),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () {
                            copyAddress();
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(

                    street + number,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    postCode,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    city,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    municipality,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    province,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 12),
                  width: (MediaQuery.of(context).size.width / 2.5),
                  child: TextField(
                    controller: postcodeController,
                    style: TextStyle(fontSize: 25.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "1234AB",
                    ),
                  ),
                ),
                VerticalDivider(width: MediaQuery.of(context).size.width / 15),
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 12),
                  width: (MediaQuery.of(context).size.width / 4),
                  child: TextField(
                    controller: numberController,
                    style: TextStyle(fontSize: 25.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "123",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            TextButton(
              child: const Text("Zoeken"),
              onPressed: () async {
                  // data versturen van view naar model
                  APIData = await dataFromAPI.getData(
                      postcodeController.text, numberController.text);
                  if(APIData.isEmpty){
                    givenDataNotCorrect();
                  } else{
                    fillInCorrectData();
                  }
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
                backgroundColor: Colors.grey[800],
                primary: Colors.white,
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
