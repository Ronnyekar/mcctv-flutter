import 'package:monitoring_cctv/Pages/home_page.dart';
import 'package:monitoring_cctv/firebase/handler.dart';
import 'package:monitoring_cctv/models/firebaseuser.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return const Handler();
    } else {
      return const HomePage();
    }
  }
}
