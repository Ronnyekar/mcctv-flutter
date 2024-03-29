import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_cctv/Pages/company_selector_page.dart';
import 'package:monitoring_cctv/constant.dart';
import 'package:monitoring_cctv/firebase/auth.dart';
import 'package:monitoring_cctv/models/loginuser.dart';
import 'package:package_info_plus/package_info_plus.dart';

Color firstcolor = const Color.fromARGB(255, 31, 56, 245);
Color secondcolor = const Color.fromARGB(255, 30, 129, 242);
Color bgColor = const Color.fromARGB(255, 255, 255, 255);

class Login extends StatefulWidget {
  final Function? toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _packageInfoText;
  String? versionName;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool _obscureText = true;
  bool rememberMe = false;

  void getInfoPlatform() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    versionName = _packageInfo.version;

    setState(() {
      _packageInfoText = "Version $versionName";
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        controller: _email,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.email,
            ),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: _password,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            prefixIcon: const Icon(
              Icons.vpn_key,
            ),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [firstColor, secondColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              dynamic result = await _auth.signInEmailPassword(
                  LoginUser(email: _email.text, password: _password.text));
              if (result.uid == null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(result.code),
                      );
                    });
              }
            }
          },
          child: Text(
            "Log in",
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    getInfoPlatform();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Container(
        padding: const EdgeInsets.only(bottom: 20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [firstColor, secondColor],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100))),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/Logo-white.png",
                        height: 300,
                        width: 300,
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        _packageInfoText.toString(),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      emailField,
                      const SizedBox(
                        height: 10,
                      ),
                      passwordField,
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: rememberMe,
                                      onChanged: (value) {
                                        setState(() => rememberMe = value!);
                                      },
                                      activeColor: Colors.black26,
                                      checkColor: Colors.black,
                                    ),
                                    Text(
                                      'Rememeber Me ..',
                                      style: kBodyText.copyWith(
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style:
                                        kBodyText.copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New?',
                            overflow: TextOverflow.ellipsis,
                            style: kBodyText.copyWith(color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                widget.toggleView!();
                              },
                              child: Text(
                                'Register Here',
                                overflow: TextOverflow.ellipsis,
                                style: kBodyText.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      loginButton
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
