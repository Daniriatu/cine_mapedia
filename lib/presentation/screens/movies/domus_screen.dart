import 'package:cine_mapedia/config/constants/enviroments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DomusScreen extends StatelessWidget {
  static const String nomen = "domus-screen";
  const DomusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Cinemapedia"),
    ));
  }
}
