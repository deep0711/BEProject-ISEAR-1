import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final List<String> imageAsset = [
    'https://www.marketing91.com/wp-content/uploads/2020/07/Business-model-of-big-bazaar.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/DLF_logo.svg/1200px-DLF_logo.svg.png',
    'https://static.wikia.nocookie.net/logopedia/images/9/95/Pantaloons.png/revision/latest/scale-to-width-down/300?cb=20200321132918',
    'https://corporate.walmart.com/_download?id=0000016d-f8b2-d758-a1ed-f8b290f10000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Current Location',
                            style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                    letterSpacing: 2.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        Text('144/7A Becker Street, New York!',
                            style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                    letterSpacing: 2.0, fontSize: 15))),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: Icon(Icons.add_location_alt_rounded,
                        size: 40, color: Colors.teal))
              ]),
              const Divider(
                height: 20,
                indent: 12.0,
                endIndent: 12.0,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.network(
                      'https://images.unsplash.com/photo-1599758069393-1b64a75a8289?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGFkdmVydGlzZW1lbnRzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                      width: 150,
                      height: 100),
                  Image.network(
                      'https://images.unsplash.com/photo-1513639304702-9116ea240a81?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzV8fGFkdmVydGlzZW1lbnRzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                      width: 150,
                      height: 100)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Welcome to ISEAR! Get Every Info of your Product Here!',
                  style: GoogleFonts.caveat(
                      textStyle: const TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 20,
                          color: Colors.black)),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                height: 30,
                indent: 20,
                endIndent: 20,
                color: Colors.black,
              ),
              Text('Top Picks For you!',
                  style: GoogleFonts.caveat(
                      textStyle: const TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 80.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: imageAsset
                      .map((item) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(item, height: 200, width: 100),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
