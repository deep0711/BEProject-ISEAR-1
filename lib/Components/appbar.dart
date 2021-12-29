import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreenAppBar extends StatefulWidget {
  const MainScreenAppBar({ Key? key }) : super(key: key);

  @override
  State<MainScreenAppBar> createState() => _MainScreenAppBarState();
}

class _MainScreenAppBarState extends State<MainScreenAppBar> {
  
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text(
    'ISEAR',
    style: GoogleFonts.caveat(
      letterSpacing: 3.0,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black
      )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: customSearchBar,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              if(customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = ListTile(
                  leading:const  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Anything !',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.caveat(
                      letterSpacing: 2.0,
                      textStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
                setState(() { });
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = Text(
                  'ISEAR',
                  style: GoogleFonts.caveat(
                    letterSpacing: 3.0,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    )
                  ),
                );
                setState(() { });
              }
            }, 
            icon: customIcon
          )
        ],
      );
  }
}