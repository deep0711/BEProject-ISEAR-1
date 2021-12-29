import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 2.0
            )
          ]
        ),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              label: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: Text(
                        'Search Anything !!!',
                        style: GoogleFonts.caveat(
                          letterSpacing: 2.0,
                          textStyle: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ) 
                    )
                  ]
                )
              ),
              prefixIcon: IconButton(
                icon: const Icon(Icons.search_outlined),
                onPressed: () {},
              ),
              suffixIcon: const Icon(Icons.send)
            ),
          )
        ),
      ),
    );
  }
}