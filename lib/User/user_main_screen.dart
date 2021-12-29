<<<<<<< HEAD
import 'dart:ui';

import 'package:be_isear/Components/appbar.dart';
=======
>>>>>>> a1422186664eada2fc1da2a2f8f195179c7e807e
import 'package:be_isear/Components/drawer.dart';
import 'package:be_isear/User/User%20Dashboard/user_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:be_isear/User/render_armodel_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:be_isear/Tensorflow/tensorflow.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({Key? key}) : super(key: key);
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
<<<<<<< HEAD

  final TextEditingController _addressController = TextEditingController();

  //To Store the Address of the Store
  String storeAddress = "";

=======
>>>>>>> a1422186664eada2fc1da2a2f8f195179c7e807e
  //File to Store Image Picked by User through Camera or Gallery
  late XFile? cameraFile;

  //To Control the navigation of fragments of Bottom Navigation Bar
  final PageController pageController = PageController(initialPage: 0);

  //FAB to tak Picture
  final FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;

  Future<bool?> askCameraPermissionFromUser() async {
    //Check the Current Status of Camera Permission
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // Camera Permission Not Granted Earlier or Never Asked
      status = await Permission.camera.request();
    }
    //return the Current status
    return status.isGranted;
  }

  // Returns the Current Address set by User
  Future<String> getUserStoreAddress() async {
    if(storeAddress == "") {
      bool? future = await showModalBottomSheet<bool>(
        elevation: 2.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50.0)
          )
        ),
        isScrollControlled: true,
        context: context, 
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 300,
              color: Colors.transparent
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Enter the Store\'s Name',
                          style: GoogleFonts.caveat(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 2.0
                            )
                          ),
                        )
                      ),
                      const SizedBox(
                        height: 20,
                      )
                      TextField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Store\'s Name',
                            prefixIcon: Icon(Icons.store)
                          ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              const _newValue = "WallMart";
                              _addressController.value = TextEditingValue(
                                text: _newValue,
                                selection: TextSelection.fromPosition(
                                  const TextPosition(offset: _newValue.length)
                                )
                              )
                            }, 
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade300)),
                            child: Text(
                              'WallMart',
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 2.0,
                                  color: Colors.black
                                )
                              ),
                            )
                          ),
                          TextButton(
                            onPressed: () {
                              const _newValue = "Big Bazar";
                              _addressController.value = TextEditingValue(
                                text: _newValue,
                                selection: TextSelection.fromPosition(
                                  const TextPosition(offset: _newValue.length)
                                )
                              )
                            }, 
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade300)),
                            child: Text(
                              'Big Bazar',
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 2.0,
                                  color: Colors.black
                                )
                              ),
                            )
                          ),
                          TextButton(
                            onPressed: () {
                              _addressController.text = "Pantaloons";
                              setState(() { });
                            }, 
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade300)),
                            child: Text(
                              'Pantaloons',
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 2.0,
                                  color: Colors.black
                                )
                              ),
                            )
                          )
                        ],
                      )
                      const SizedBox(
                        height: 20
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context)
                            }, 
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                            child: Text(
                              'Done ?',
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 2.0,
                                  color: Colors.black
                                )
                              ),
                            )
                          ),
                          ElevatedButton(
                            onPressed: () {
                             
                            }, 
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.location_pin)
                                Text(
                                  'Wanna Try GPS?',
                                  style: GoogleFonts.caveat(
                                    textStyle: const TextStyle(
                                      fontSize: 15.0,
                                      letterSpacing: 2.0,
                                      color: Colors.black
                                    )
                                  ),
                                ),
                              ],
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ); 
    }
    return storeAddress;
  }

  Future<void> selectFromCamera() async {
    //create a instance of Image Picker
    final ImagePicker _picker = ImagePicker();

    cameraFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front // Back side Camera
        );
  }

  @override
  void dispose() {
    //Dispose the Controller Variables
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MainScreenAppBar(),
      ),
=======
      appBar: AppBar(
          title: Text(
        'ISEAR',
        style: GoogleFonts.caveat(
            letterSpacing: 3.0,
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      )),
>>>>>>> a1422186664eada2fc1da2a2f8f195179c7e807e
      body: PageView(
        controller: pageController,
        children: <Widget>[
          Container(color: Colors.grey.shade200, child: const UserDashboard()),
          Container(
            color: Colors.white,
            child: Center(
                child: Text(
              'User Dashboard',
              style: GoogleFonts.caveat(),
            )),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text('Third Page'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
<<<<<<< HEAD
        onPressed: () async { 
          //Get the User Store Address
          String userStoreAddress = await getUserStoreAddress();
=======
        onPressed: () async {
>>>>>>> a1422186664eada2fc1da2a2f8f195179c7e807e
          //Check for Camera Permission from user
          bool? permissionGranted = await askCameraPermissionFromUser();
          if (permissionGranted != null && permissionGranted) {
            await selectFromCamera();
            if (cameraFile != null) {
              // Now, pass the image to the model, predict it then from there pass it to the renderARModel
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Tensorflow(
                          cameraPermission: true, pickedImage: cameraFile)));
            }
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const RenderArModelScreen(cameraPermission: false)));
          }
        },
        child: const Icon(Icons.camera),
      ),
      drawer: CustomDrawer(),
      floatingActionButtonLocation: _fabLocation,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(0);
                  });
                },
                icon: const Icon(Icons.dashboard),
                tooltip: 'DashBoard',
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(1);
                  });
                },
                icon: const Icon(Icons.favorite),
                tooltip: 'Favorites',
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(2);
                  });
                },
                icon: const Icon(Icons.search),
                tooltip: 'Search',
              )
            ],
          ),
        ),
      ),
    );
  }
}
