import 'dart:developer';
import 'dart:io';

import 'package:be_isear/User/render_armodel_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Tensorflow extends StatefulWidget {
  final bool
      cameraPermission; // True if the user has provided Camera Permission, else False
  final XFile? pickedImage;

  const Tensorflow(
      {Key? key, required this.cameraPermission, required this.pickedImage})
      : super(key: key);

  @override
  _TensorflowState createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {
  @override
  void initState() {
    super.initState();

    loadModel().then((value) {
      print('Loading Model...');
      classifyImage(File(widget.pickedImage!.path));
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "Assets/model_unquant.tflite",
      labels: "Assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    //return output[0]["label"]
    if (output == null) {
      print('Model Prediction Failed');
      return;
    }

    print(output);

    String label = output[0]["label"];
    String confidence = output[0]["confidence"].toString();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RenderArModelScreen(
                cameraPermission: true, label: label, confidence: confidence)));
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Processing..'),
        ),
        body: Center(
            child: Text(
          'Loading Your Model .... hang Tight!!!',
          textAlign: TextAlign.center,
          style: GoogleFonts.caveat(
              textStyle: const TextStyle(letterSpacing: 3.0, fontSize: 25)),
        ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
