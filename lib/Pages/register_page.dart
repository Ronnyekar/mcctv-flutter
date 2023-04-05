import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_cctv/Pages/login_page.dart';
import 'package:monitoring_cctv/constant.dart';
import 'package:monitoring_cctv/models/loginuser.dart';
import 'package:monitoring_cctv/firebase/auth.dart';

Color firstcolor = const Color.fromARGB(255, 31, 56, 245);
Color secondcolor = const Color.fromARGB(255, 30, 129, 242);
Color bgColor = const Color.fromARGB(255, 255, 255, 255);

class RegisterPage extends StatefulWidget {
  final Function? toggleView;
  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  final AuthService _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [firstcolor, secondcolor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              dynamic result = await _auth.registerEmailPassword(
                  LoginUser(email: _email.text, password: _password.text));
              if (result.uid == null) {
                //null means unsuccessfull authentication
                // ignore: use_build_context_synchronously
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
            "Register",
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            HeaderContainer(''),
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
                        height: 20,
                      ),
                      passwordField,
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New?',
                            style: kBodyText.copyWith(color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                widget.toggleView!();
                              },
                              child: Text(
                                'Register Here',
                                style: kBodyText.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      registerButton
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

class HeaderContainer extends StatelessWidget {
  var text = "Signin";
  HeaderContainer(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [firstcolor, secondcolor],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                text,
                style: kBodyText2,
              )),
          Center(
            child: Image.asset(
              "images/Logo-white.png",
              height: 300,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
