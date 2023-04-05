import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_cctv/Pages/login_page.dart';
import 'package:monitoring_cctv/dashboard_item.dart';
import 'package:monitoring_cctv/firebase/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'PT IDU-1';
  final AuthService _auth = new AuthService();
  @override
  Widget build(BuildContext context) {
    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _auth.signOut();
        },
        child: Text(
          "Log out",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white70.withOpacity(0.9),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Color.fromARGB(255, 31, 56, 245),
              // color: Colors.orangeAccent.shade700,
            ),
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.only(left: 90, bottom: 20),
            width: 299,
            height: 279,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 30, 129, 242),
                // color: Colors.orangeAccent.shade400,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(160),
                    bottomLeft: Radius.circular(290),
                    bottomRight: Radius.circular(160),
                    topRight: Radius.circular(10))),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: dropdownValue,
                      dropdownColor: Colors.grey,
                      items: <String>[
                        'PT IDU-1',
                        'PT IDU-2',
                        'PT IDU-3',
                        'PT IDU-4',
                        'PT IDU-5'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'LOGOUT',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () async {
                              // await _auth.signOut();
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        await _auth.signOut();
                        // Navigator.push(
                        //   context,
                        //   CupertinoPageRoute(
                        //       builder: (context) => const dashboard()),
                        // );
                      },
                      alignment: Alignment.topCenter,
                      icon: Image.asset(
                        'images/setting.png',
                        color: Colors.white,
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              DashboardItem(),
            ],
          )
        ],
      )),
    );
  }
}
