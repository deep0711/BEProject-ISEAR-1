
import 'package:image_picker/image_picker.dart';
import 'package:be_isear/Authentication/firebase_authentication.dart';
import 'package:be_isear/User/render_armodel_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({ Key? key }) : super(key: key);
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {

  //File to Store Image Picked by User through Camera or Gallery
  late XFile? cameraFile;

  //To Control the navigation of fragments of Bottom Navigation Bar
  final PageController pageController = PageController(initialPage: 0);

  //FAB to tak Picture
  final FloatingActionButtonLocation _fabLocation = FloatingActionButtonLocation.endDocked;

  Future<bool?> askCameraPermissionFromUser() async {
    //Check the Current Status of Camera Permission
    var status = await Permission.camera.status;
    if(status.isDenied) {
      // Camera Permission Not Granted Earlier or Never Asked
      status = await Permission.camera.request();
    }
    //return the Current status
    return status.isGranted;
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
      appBar: AppBar(
        title: const Text('Main Screen'),
        centerTitle: true,
        titleSpacing: 2.0,
        bottomOpacity: 2.0,
      ),
      body: PageView(
        controller: pageController,
        children:<Widget> [ 
          Container(
            color: Colors.grey.shade200,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await FireBaseAuthHelper.signOutuser();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                },
                child: const Text('Sign Out!'),
              ),
            ),
          ),
          Container(
            color: Colors.amber,
            child: const Center(
              child: Text('Second Page'),
            ),
          ),
          Container(
            color: Colors.amber,
            child: const Center(
              child: Text('Third Page'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async { 
          //Check for Camera Permission from user
          bool? permissionGranted = await askCameraPermissionFromUser();
          if( permissionGranted != null &&  permissionGranted) {
            await selectFromCamera();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RenderArModelScreen(cameraPermission: true , pickedImage: cameraFile))
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RenderArModelScreen(cameraPermission: false))
            );
          }
        },
        child: const Icon(Icons.camera),
      ),
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