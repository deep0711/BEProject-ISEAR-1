import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class RenderArModelScreen extends StatefulWidget {
  final bool
      cameraPermission; // True if the user has provided Camera Permission, else False
  final String? label;
  final String? confidence;

  const RenderArModelScreen(
      {Key? key, required this.cameraPermission, this.label, this.confidence})
      : super(key: key);

  @override
  _RenderArModelScreenState createState() => _RenderArModelScreenState();
}

class _RenderArModelScreenState extends State<RenderArModelScreen> {
  //On basis of cameraPermission render different Bodies

  late ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController _controller) {
    arCoreController = _controller;
    //arCoreController.onNodeTap = (name) => onTapHandler(name);
    _addModel(arCoreController);
  }

  _addModel(ArCoreController _controller) async {
    final ByteData textureBytes;

    if (widget.label == 'Banana')
      textureBytes = await rootBundle.load('Assets/Banana.png');
    else if (widget.label == 'Orange')
      textureBytes = await rootBundle.load('Assets/Orange.png');
    else
      textureBytes = await rootBundle.load('Assets/Cabbage.png');

    final material = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244),
        textureBytes: textureBytes.buffer.asUint8List());

    //Adding a Cube
    final cube =
        ArCoreCube(materials: [material], size: vector.Vector3(0.1, 0.1, 0.1));

    final cubenode = ArCoreNode(shape: cube, position: vector.Vector3(0, 0, 0));

    _controller.addArCoreNode(cubenode);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label! + '-' + widget.confidence!),
        centerTitle: true,
        titleSpacing: 2.0,
        bottomOpacity: 2.0,
      ),
      body: widget.cameraPermission == true
          ? ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            )
          : Center(
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
                                fontSize: 30.0, letterSpacing: 2.0)),
                      ))
                ],
              ),
            ),
    );
  }
}
