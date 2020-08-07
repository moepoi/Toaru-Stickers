import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:railgun_t_whatsapp/src/utils.dart';

class ListPacks extends StatefulWidget {
  @override
  _ListPacksState createState() => _ListPacksState();
}

class _ListPacksState extends State<ListPacks> {
  final WhatsAppStickers _waStickers = WhatsAppStickers();

  final String _stickerPackIdentifier1 = "1";
  final String _stickerPackName1 = "Toaru Kagaku No Railgun T";
  final String _stickerPackImage1 = "assets/1.png";

  final String _stickerPackIdentifier2 = "2";
  final String _stickerPackName2 = "Toaru Kagaku No Railgun S";
  final String _stickerPackImage2 = "assets/2.png";

  final String _stickerPackIdentifier3 = "3";
  final String _stickerPackName3 = "Toaru Majutsu No Index";
  final String _stickerPackImage3 = "assets/3.png";

  final String _stickerPackIdentifier4 = "4";
  final String _stickerPackName4 = "Toaru Majutsu No Index 2";
  final String _stickerPackImage4 = "assets/4.png";

  bool _stickerPackInstalled1 = false;
  bool _stickerPackInstalled2 = false;
  bool _stickerPackInstalled3 = false;
  bool _stickerPackInstalled4 = false;

  @override
  void initState() {
    super.initState();
    checkInstallationStatuses();
  }

  void checkInstallationStatuses() async {
    bool installed1 =
        await _waStickers.isStickerPackInstalled(_stickerPackIdentifier1);
    bool installed2 =
        await _waStickers.isStickerPackInstalled(_stickerPackIdentifier2);
    bool installed3 =
        await _waStickers.isStickerPackInstalled(_stickerPackIdentifier3);
    bool installed4 =
        await _waStickers.isStickerPackInstalled(_stickerPackIdentifier4);
    setState(() {
      _stickerPackInstalled1 = installed1;
      _stickerPackInstalled2 = installed2;
      _stickerPackInstalled3 = installed3;
      _stickerPackInstalled4 = installed4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 40),
      children: <Widget>[
        stickerPack(
            _stickerPackName1, _stickerPackIdentifier1, _stickerPackInstalled1, _stickerPackImage1),
        Divider(height: 40),
        stickerPack(
            _stickerPackName2, _stickerPackIdentifier2, _stickerPackInstalled2, _stickerPackImage2),
        Divider(height: 40),
        stickerPack(
            _stickerPackName3, _stickerPackIdentifier3, _stickerPackInstalled3, _stickerPackImage3),
        Divider(height: 40),
        stickerPack(
            _stickerPackName4, _stickerPackIdentifier4, _stickerPackInstalled4, _stickerPackImage4),
      ],
    );
  }

  Widget stickerPack(String name, String identifier, bool installed, String image) {
    String status = installed ? "Installed" : "Not Installed";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("$name ($status)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
        SizedBox(height: 10),
        Image.asset(image, height: 150, width: 150,),
        RaisedButton(
          child: Text("Install"),
          onPressed: () async {
            _waStickers.addStickerPack(
              packageName: WhatsAppPackage.Consumer,
              stickerPackIdentifier: identifier,
              stickerPackName: name,
              listener: (action, result, {error}) => processResponse(
                action: action,
                result: result,
                error: error,
                successCallback: checkInstallationStatuses,
                context: context,
              ),
            );
          },
        )
      ],
    );
  }
}