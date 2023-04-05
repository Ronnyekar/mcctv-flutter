import 'package:flutter/material.dart';
import 'package:monitoring_cctv/constant.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    // required Key key,
    required this.hintText,
    required this.inputType,
  });
  //  : super(key: key);
  final String hintText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: kBodyText.copyWith(color: Colors.black),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText.copyWith(color: Colors.black38),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

class MyTextField2 extends StatelessWidget {
  const MyTextField2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
