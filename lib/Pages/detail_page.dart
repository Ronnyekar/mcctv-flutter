import 'package:flutter/material.dart';
import 'package:monitoring_cctv/models/cctv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase/firebase_crud.dart';

Color firstcolor = const Color.fromARGB(255, 31, 56, 245);
Color secondcolor = const Color.fromARGB(255, 30, 129, 242);
Color secondcolor2 = Color.fromARGB(255, 197, 211, 227);
Color thirdcolor = const Color.fromARGB(255, 255, 255, 255);

class DetailPage extends StatefulWidget {
  final Cctv? cctv;
  final String? cctv_name;
  final String? cctv_ip;
  final String? cctv_lokasi;
  final String? cctv_status;
  DetailPage(
      {this.cctv,
      this.cctv_name,
      this.cctv_ip,
      this.cctv_lokasi,
      this.cctv_status});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Stream<QuerySnapshot> CollectionReference = FirebaseCRUD.readCctv();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white70.withOpacity(0.9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [firstcolor, secondcolor],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: AppBar().preferredSize.height + 40,
                  height: AppBar().preferredSize.height,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                    child: Center(
                  child: Text(
                    'Detail Page',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                )),
                SizedBox(
                  width: AppBar().preferredSize.height + 40,
                  height: AppBar().preferredSize.height,
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: CollectionReference,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [secondcolor, thirdcolor])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        "",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const <Widget>[
                                    Text(
                                      'DATA DETAILS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                69, 67, 66, 0.298),
                                            blurRadius: 20,
                                            offset: Offset(10, 10))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            const Text(
                                              "#IP",
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: const <Widget>[
                                                    Text(
                                                      "Lokasi",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    Text("#LOKASI",
                                                        style: TextStyle(
                                                            fontSize: 20))
                                                  ],
                                                ),
                                                Column(
                                                  children: const <Widget>[
                                                    Text(
                                                      "Status",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    Text("#STATUS",
                                                        style: TextStyle(
                                                            fontSize: 20))
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                69, 67, 66, 0.298),
                                            blurRadius: 20,
                                            offset: Offset(10, 10))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const <Widget>[
                                            Text(
                                              "Latitude : " + "#LATITUDE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "Longitude : " + "#LONGITUDE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color.fromARGB(255, 108, 232, 84)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.network_ping_sharp,
                                            size: 30,
                                          )),
                                      const Text(
                                        "PING",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [secondcolor, firstcolor])),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {
                                        //            Navigator.pushAndRemoveUntil<dynamic>(
                                        //   context,
                                        //   MaterialPageRoute<dynamic>(
                                        //     builder: (BuildContext context) => EditPage(
                                        //       cctv: Cctv(
                                        //         id: e.id,
                                        //         cctvname: e["cctv_name"],
                                        //         cctvip: e["cctv_ip"],
                                        //         cctvlocation: e["cctv_location"],
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   (route) => true,
                                        // );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 35,
                                      )),
                                  const Text(
                                    "EDIT",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.location_pin,
                                        size: 35,
                                      )),
                                  const Text(
                                    "MAPS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 35,
                                      )),
                                  const Text(
                                    "DELETE",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
