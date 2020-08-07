import 'package:flutter/material.dart';
import 'package:railgun_t_whatsapp/src/about.dart';
import 'package:railgun_t_whatsapp/src/list_packs.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Toaru Stickers';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.amber,
            bottom: TabBar(
              tabs: [
                Tab(text: "List Stickers"),
                Tab(text: "About"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListPacks(),
              About()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false
    );
  }
}