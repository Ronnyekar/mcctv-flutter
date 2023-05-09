import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_cctv/Pages/add_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monitoring_cctv/Pages/edit_page.dart';
import 'package:monitoring_cctv/Pages/search_page.dart';
import 'package:monitoring_cctv/models/cctv.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:monitoring_cctv/firebase/firebase_crud.dart';

Color firstcolor = const Color.fromARGB(255, 31, 56, 245);
Color secondcolor = const Color.fromARGB(255, 30, 129, 242);
Color thirdcolor = const Color.fromARGB(255, 255, 255, 255);

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  AnimationController? animationController;

  final Stream<QuerySnapshot> CollectionReference = FirebaseCRUD.readCctv();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    'Data',
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
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const AddPage()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: CollectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Slidable(
                    actionPane: const SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: "EDIT",
                        color: Colors.transparent,
                        foregroundColor: Colors.black,
                        icon: Icons.edit,
                        onTap: () {
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => EditPage(
                                cctv: Cctv(
                                  id: e.id,
                                  cctvname: e["cctv_name"],
                                  cctvip: e["cctv_ip"],
                                  cctvlocation: e["cctv_location"],
                                ),
                              ),
                            ),
                            (route) => true,
                          );
                        },
                      ),
                      IconSlideAction(
                        caption: 'DELETE',
                        color: Colors.transparent,
                        foregroundColor: Colors.black,
                        icon: Icons.delete,
                        onTap: () async {
                          await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Hapus Data'),
                                  content: SingleChildScrollView(
                                    child: ListBody(),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () async {
                                          var response =
                                              await FirebaseCRUD.deleteCctv(
                                                  docid: e.id);
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                          if (response.code != 200) {
                                            // ignore: use_build_context_synchronously
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(response
                                                        .message
                                                        .toString()),
                                                  );
                                                });
                                          }
                                        },
                                        child: Text("Ya")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Tidak"))
                                  ],
                                );
                              });
                          // var response =
                          //     await FirebaseCRUD.deleteCctv(docid: e.id);
                          // if (response.code != 200) {
                          //   // ignore: use_build_context_synchronously
                          //   showDialog(
                          //       context: context,
                          //       builder: (context) {
                          //         return AlertDialog(
                          //           content: Text(response.message.toString()),
                          //         );
                          //       });
                          // }
                        },
                      ),
                    ],
                    child: Card(
                      child: Column(children: <Widget>[
                        ListTile(
                          contentPadding: const EdgeInsets.only(
                              left: 15, right: 20, top: 5, bottom: 5),
                          title: Text(
                            e["cctv_name"],
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Container(
                            padding: const EdgeInsets.only(
                              top: 7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("IP CCTV : " + e['cctv_ip'],
                                    style: const TextStyle(fontSize: 14)),
                                Text("Location : " + e['cctv_location'],
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          trailing: AnimatedContainer(
                            height: 30,
                            width: 60,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Colors.black12,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Location...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child:
                      Icon(Icons.search_sharp, size: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
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
                  'Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.transparent,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: const <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.sort, color: Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}
