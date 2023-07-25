import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_cctv/Pages/data_page.dart';

class Items {
  String title;
  String subtitle;
  String img;
  VoidCallback onTap;
  Items(
      {required this.title,
      required this.subtitle,
      required this.img,
      required this.onTap});
}

class DashboardItem extends StatelessWidget {
  DashboardItem({super.key});

  @override
  Widget build(BuildContext context) {
    Items item1 = Items(
      title: "Data",
      subtitle: "",
      img: "images/todo.png",
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => DataPage(),
            ));
      },
    );

    Items item2 = Items(
      title: "Maps",
      subtitle: "",
      img: "images/map.png",
      onTap: () {
        showDialog(
            context: context, builder: ((context) => (const AlertWidget())));
      },
    );
    Items item3 = Items(
      title: "Eksport",
      subtitle: "",
      img: "images/export.jpg",
      onTap: () {
        showDialog(
            context: context, builder: ((context) => (const AlertWidget())));
      },
    );
    Items item4 = Items(
      title: "Import",
      subtitle: "",
      img: "images/import.jpg",
      onTap: () {
        showDialog(
            context: context, builder: ((context) => (const AlertWidget())));
      },
    );

    List<Items> myList = [item1, item2, item3, item4];
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 6.0)
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: data.onTap,
                    child: Image.asset(
                      data.img,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  const AlertWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Coming Soon ...'),
    );
  }
}
