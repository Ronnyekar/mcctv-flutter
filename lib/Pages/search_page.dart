import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                hintText: 'Search ..',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
