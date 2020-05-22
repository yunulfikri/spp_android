import 'package:flutter/material.dart';
import 'package:spp_app/Home.dart';
import 'loader.dart';
import 'package:spp_app/loader.dart';

class Home2 extends StatefulWidget {
  final VoidCallback signOut;

  Home2(
    this.signOut,
  );
  @override
  _Home2State createState() => _Home2State();
}



class _Home2State extends State<Home2> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Loader(),
      ),
    );
  }
}


