
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RenderArModelScreen extends StatefulWidget {
  final bool cameraPermission; // True if the user has provided Camera Permission, else False
  final XFile? pickedImage;
  const RenderArModelScreen({ Key? key , required this.cameraPermission , this.pickedImage }) : super(key: key);

  @override
  _RenderArModelScreenState createState() => _RenderArModelScreenState();
}

class _RenderArModelScreenState extends State<RenderArModelScreen> {
  //On basis of cameraPermission render different Bodies

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Render Ar Model'),
          centerTitle: true,
          titleSpacing: 2.0,
          bottomOpacity: 2.0,
        ),
        body: widget.cameraPermission == true ?
            Center(
              child: Text(
                'Loading Your Model .... hang Tight!!!',
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                  textStyle: const TextStyle(
                    letterSpacing: 3.0,
                    fontSize: 25
                  )
                ),
              )
            )
            :
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Permission Denied'),
                  TextButton(
                    onPressed: () async {
                      await openAppSettings();
                    }, 
                    child: Text(
                      'Open Settings',
                      style: GoogleFonts.caveat(
                        textStyle: const TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 2.0
                        )
                      ),
                    )
                  )
                ],
              ),
            ),
      );
  }
}