import 'package:flutter/gestures.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Column(
          children: [
            Divider(height: MediaQuery.of(context).size.height / 15),
            Container(
              height: (MediaQuery.of(context).size.height / 2.5),
              width: (MediaQuery.of(context).size.width / 1.25),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
            Divider(height: MediaQuery.of(context).size.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height / 12),
                  width: (MediaQuery.of(context).size.width / 2.5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                ),
                VerticalDivider(width: MediaQuery.of(context).size.width / 15),
                Container(
                  height: (MediaQuery.of(context).size.height / 12),
                  width: (MediaQuery.of(context).size.width / 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 50),
            TextButton(
              child: const Text("Zoeken"),
              onPressed: () async {
                postCodeAPI dataFromAPI = new postCodeAPI();
                Map<String, String> APIData = await dataFromAPI.getData();
                print(APIData.values.elementAt(1));
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
                backgroundColor: Colors.yellow,
                primary: Colors.pink,
                padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
