import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String _platformVersion = 'Unknown';
  bool _whatsAppInstalled = false;
  bool _whatsAppConsumerAppInstalled = false;
  bool _whatsAppSmbAppInstalled = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    String platformVersion;

    try {
      platformVersion = await WhatsAppStickers.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    bool whatsAppInstalled = await WhatsAppStickers.isWhatsAppInstalled;
    bool whatsAppConsumerAppInstalled =
        await WhatsAppStickers.isWhatsAppConsumerAppInstalled;
    bool whatsAppSmbAppInstalled =
        await WhatsAppStickers.isWhatsAppSmbAppInstalled;

    setState(() {
      _platformVersion = platformVersion;
      _whatsAppInstalled = whatsAppInstalled;
      _whatsAppConsumerAppInstalled = whatsAppConsumerAppInstalled;
      _whatsAppSmbAppInstalled = whatsAppSmbAppInstalled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Created by', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/creator.jpg', width: 55, height: 55),
                      )
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Text('Moe Poi ~', style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(right: 45),
                            child: GestureDetector(
                              onTap: () async {
                                await launch('https://github.com/moepoi');
                              },
                              child: Image.asset('assets/github.png', width: 20, height: 20,)
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
                Divider(height: 40),
                Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 20),
                Text('Running on: $_platformVersion'),
                Text("WhatsApp Installed: $_whatsAppInstalled"),
                Text("WhatsApp Consumer Installed: $_whatsAppConsumerAppInstalled"),
                Text("WhatsApp Business Installed: $_whatsAppSmbAppInstalled"),
              ],
            )
          ],
        ));
  }
}
