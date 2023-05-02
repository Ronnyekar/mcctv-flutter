import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_cctv/Pages/home_page.dart';
import 'package:monitoring_cctv/constant.dart';
import 'package:monitoring_cctv/widget/text_button.dart';

Color firstColor = const Color.fromARGB(255, 31, 56, 245);
Color secondColor = const Color.fromARGB(255, 30, 129, 242);

class SelectCompanyPage extends StatefulWidget {
  const SelectCompanyPage({super.key});

  @override
  State<SelectCompanyPage> createState() => _SelectCompanyPageState();
}

class _SelectCompanyPageState extends State<SelectCompanyPage> {
  String dropdownValue = 'PT IDU-1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(30)),
                  color: firstColor,
                ),
                width: double.infinity,
              ),
              Container(
                margin: const EdgeInsets.only(left: 90, bottom: 20),
                width: 299,
                height: 279,
                decoration: BoxDecoration(
                    color: secondColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(160),
                        bottomLeft: Radius.circular(290),
                        bottomRight: Radius.circular(160),
                        topRight: Radius.circular(10))),
              ),
              CustomScrollView(
                reverse: true,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Company',
                                      style: kHeadline.copyWith(
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 170,
                              ),
                              Text('Please select your company : ',
                                  style:
                                      kBodyText.copyWith(color: Colors.black)),
                              Container(
                                width: double.infinity,
                                height: 60,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      dropdownColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      items: <String>[
                                        'PT IDU-1',
                                        'PT IDU-2',
                                        'PT IDU-3',
                                        'PT IDU-4',
                                        'PT IDU-5'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 25),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextButton(
                                  buttonName: 'Select',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  },
                                  bgColor: Colors.black12,
                                  textColor: Colors.black)
                            ],
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
