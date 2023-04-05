import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_cctv/Pages/data_page.dart';
import 'package:monitoring_cctv/firebase/firebase_crud.dart';
import 'package:monitoring_cctv/models/cctv.dart';
import '../constant.dart';
import 'package:monitoring_cctv/widget/widget.dart';

Color bgColor = Colors.white70.withOpacity(0.9);
Color firstcolor = const Color.fromARGB(255, 31, 56, 245);
Color secondcolor = const Color.fromARGB(255, 30, 129, 242);
Color thirdcolor = const Color.fromARGB(255, 255, 255, 255);

class EditPage extends StatefulWidget {
  final Cctv? cctv;
  EditPage({this.cctv});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String dropdownValue = "Kantor Pusat";

  final _cctv_name = TextEditingController();
  final _cctv_ip = TextEditingController();
  final _cctv_location = TextEditingController();
  final _docid = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    _docid.value = TextEditingValue(text: widget.cctv!.id.toString());
    _cctv_name.value = TextEditingValue(text: widget.cctv!.cctvname.toString());
    _cctv_ip.value = TextEditingValue(text: widget.cctv!.cctvip.toString());
    _cctv_location.value =
        TextEditingValue(text: widget.cctv!.cctvlocation.toString());
  }

  @override
  Widget build(BuildContext context) {
    final docIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nameField = TextFormField(
        controller: _cctv_name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final ipField = TextFormField(
        controller: _cctv_ip,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Position",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => DataPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('View List of Employee'));

    Widget LocationDD() {
      return DropdownButton<String>(
        value: dropdownValue,
        dropdownColor: Colors.white,
        items: <String>[
          'Kantor Pusat',
          'Kantor Cabang',
          'Jamrud',
          'Nilam',
          'Mirah',
          'GSN'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
      );
    }

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCRUD.updateCctv(
              cctvname: _cctv_name.text,
              cctvip: _cctv_ip.text,
              cctvlocation: _cctv_location.text,
            );
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [firstcolor, thirdcolor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
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
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 25,
                    ),
                    nameField,
                    const SizedBox(
                      height: 25,
                    ),
                    ipField,
                    const SizedBox(
                      height: 35,
                    ),
                    LocationDD(),
                    const SizedBox(
                      height: 45,
                    ),
                    SaveButon,
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ))
        ],
      ),

      // body: SafeArea(
      //   child: CustomScrollView(
      //     slivers: [
      //       SliverFillRemaining(
      //         hasScrollBody: false,
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(
      //             horizontal: 20,
      //           ),
      //           child: Column(
      //             children: [
      //               Flexible(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: <Widget>[
      //                     const SizedBox(
      //                       height: 30,
      //                     ),
      //                     Text(
      //                       'EDIT DATA',
      //                       style: kBodyText2.copyWith(
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                     const SizedBox(
      //                       height: 170,
      //                     ),
      //                     _textInput(hint: 'Username', icon: Icons.email),
      //                     _textInput(hint: 'Password', icon: Icons.vpn_key),
      //                     Align(
      //                       alignment: Alignment.topRight,
      //                       child: Row(
      //                         children: [
      //                           const Text(
      //                             'Location : ',
      //                             style: TextStyle(
      //                                 color: Colors.black,
      //                                 fontSize: 20,
      //                                 fontWeight: FontWeight.w400),
      //                           ),
      //                           const SizedBox(
      //                             width: 50,
      //                           ),
      //                           DropdownButton<String>(
      //                             value: dropdownValue,
      //                             dropdownColor: Colors.white,
      //                             items: <String>[
      //                               'Kantor Pusat',
      //                               'Kantor Cabang',
      //                               'Jamrud',
      //                               'Nilam',
      //                               'Mirah',
      //                               'GSN'
      //                             ].map<DropdownMenuItem<String>>(
      //                                 (String value) {
      //                               return DropdownMenuItem<String>(
      //                                 value: value,
      //                                 child: Text(
      //                                   value,
      //                                   style: const TextStyle(
      //                                       color: Colors.black, fontSize: 20),
      //                                 ),
      //                               );
      //                             }).toList(),
      //                             onChanged: (String? newValue) {
      //                               setState(() {
      //                                 dropdownValue = newValue!;
      //                               });
      //                             },
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     const Spacer(),
      //                     InkWell(
      //                       onTap: () {
      //                         Navigator.push(
      //                             context,
      //                             CupertinoPageRoute(
      //                                 builder: (context) => const DataPage()));
      //                       },
      //                       child: Container(
      //                         width: double.infinity,
      //                         height: 40,
      //                         decoration: BoxDecoration(
      //                             gradient: LinearGradient(
      //                               colors: [firstcolor, secondcolor],
      //                               begin: Alignment.topCenter,
      //                               end: Alignment.bottomCenter,
      //                             ),
      //                             borderRadius: const BorderRadius.all(
      //                                 Radius.circular(100))),
      //                         alignment: Alignment.center,
      //                         child: const Text(
      //                           'UPDATE',
      //                           style: TextStyle(
      //                               color: Colors.white,
      //                               fontSize: 20,
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.black26,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}