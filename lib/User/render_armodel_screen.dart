import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class RenderArModelScreen extends StatefulWidget {
  final bool
      cameraPermission; // True if the user has provided Camera Permission, else False
  final String? label;

  const RenderArModelScreen(
      {Key? key, required this.cameraPermission, this.label})
      : super(key: key);

  @override
  _RenderArModelScreenState createState() => _RenderArModelScreenState();
}

class _RenderArModelScreenState extends State<RenderArModelScreen> {
  //On basis of cameraPermission render different Bodies

  late ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController _controller) {
    arCoreController = _controller;
    _addSphere(arCoreController);
    _addCube(arCoreController);
    _addCyclinder(arCoreController);
  }

  _addSphere(ArCoreController _controller) {
    final material = ArCoreMaterial(color: Colors.deepOrange);
    final sphere = ArCoreSphere(materials: [material], radius: 0.2);
    final node = ArCoreNode(shape: sphere, position: vector.Vector3(0, 0, -1));

    _controller.addArCoreNode(node);
  }

  _addCyclinder(ArCoreController _controller) {
    final material = ArCoreMaterial(color: Colors.green, reflectance: 1);
    final cylinder =
        ArCoreCylinder(materials: [material], radius: 0.4, height: 0.3);
    final node = ArCoreNode(
      shape: cylinder,
      position: vector.Vector3(
        0,
        -2.5,
        -3.0,
      ),
    );

    _controller.addArCoreNode(node);
  }

  _addCube(ArCoreController _controller) {
    final material = ArCoreMaterial(color: Colors.pink, metallic: 1);
    final cube =
        ArCoreCube(materials: [material], size: vector.Vector3(1, 1, 1));
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(
        -0.5,
        -0.5,
        -3,
      ),
    );

    _controller.addArCoreNode(node);
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
        title: const Text('Render Ar Model'),
        centerTitle: true,
        titleSpacing: 2.0,
        bottomOpacity: 2.0,
      ),
      body: widget.cameraPermission == true
          ? ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
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
