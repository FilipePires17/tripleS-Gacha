import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return Center(
      child: Container(
          width: 0.911 * itemWidth,
          height: itemWidth * 1.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: theme.colorScheme.background),
          child: Column(children: [
            Expanded(
              child: Center(
                child: Text(
                  'Licenses and credits',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Pretendard',
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Color(0xFF080809)),
                ),
              ),
            ),
            SizedBox(
              width: 0.911 * itemWidth,
              height: 0.911 * itemWidth,
              child: ListView(children: [
                Padding(
                  padding: EdgeInsets.all(0.05 * itemWidth),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'Made by filipe#8416, id: fuli. With a big help from ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Luwiblu',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              Uri url = Uri.parse('https://linktr.ee/luwiblu');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                        TextSpan(text: '. For WAVes.')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0.05 * itemWidth),
                  child: RichText(
                    text: TextSpan(
                        text:
                            'This app is not affiliated with Modhaus. All Objekt assets are property of Modhaus.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0.02 * itemWidth),
                  child: Text(
                    'Icons',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
                CreditLink(
                    msg: 'Tune icons created by icon wind - Flaticon',
                    url: Uri.parse('https://www.flaticon.com/free-icons/tune')),
                CreditLink(
                    msg: 'Icons made by Freepik from www.flaticon.com',
                    url: Uri.parse('https://www.freepik.com')),
                CreditLink(
                    msg: 'Shop icons created by Saepul Nahwan - Flaticon',
                    url: Uri.parse('https://www.flaticon.com/free-icons/shop')),
                CreditLink(
                    msg: 'Drop down menu icons created by Any Icon - Flaticon',
                    url: Uri.parse(
                        'https://www.flaticon.com/free-icons/drop-down-menu')),
                CreditLink(
                    msg: 'Icons made by Roundicons from www.flaticon.com',
                    url: Uri.parse(
                        'https://www.flaticon.com/authors/roundicons')),
                CreditLink(
                    msg: 'Icons made by Freepik from www.flaticon.com',
                    url: Uri.parse('https://www.flaticon.com/authors/freepik')),
                Padding(
                  padding: EdgeInsets.all(0.02 * itemWidth),
                  child: Text(
                    'Fonts',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'Copyright (c) 2021 Kil Hyung-jin, with Reserved Font Name Pretendard.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'https://github.com/orioncactus/pretendard',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              Uri url = Uri.parse(
                                  'https://github.com/orioncactus/pretendard');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'The Dionaea Fonts are made by Svein Kåre Gunnarson ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'http://www.dionaea.com/information/fonts.html',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              Uri url = Uri.parse(
                                  'http://www.dionaea.com/information/fonts.html');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              color: Color(0xFFE9ECEF),
              height: 2,
              width: double.infinity,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: theme.colorScheme.background,
              ),
              height: 0.2 * itemWidth - 2,
              width: double.infinity,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: theme.colorScheme.secondary),
                ),
              ),
            )
          ])),
    );
  }
}

class CreditLink extends StatelessWidget {
  final String msg;
  final Uri url;
  const CreditLink({super.key, required this.msg, required this.url});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: 0.05 * itemWidth, right: 0.05 * itemWidth, top: 5, bottom: 5),
      child: RichText(
        text: TextSpan(
          text: msg,
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              //Uri url = Uri.parse('https://www.flaticon.com/free-icons/tune');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
        ),
      ),
    );
  }
}
