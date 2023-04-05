import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:monitoring_cctv/Pages/login_page.dart';
import 'package:monitoring_cctv/Pages/register_page.dart';

class Handler extends StatefulWidget {
  const Handler({super.key});

  @override
  State<Handler> createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {
  bool showSignin = true;

  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return Login(toggleView: toggleView);
    } else {
      return RegisterPage(toggleView: toggleView);
    }
  }
}
