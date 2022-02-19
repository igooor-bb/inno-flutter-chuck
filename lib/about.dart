import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("About"),
      content: const Text(
          "Hello, I am Igor Belov, 3rd-year student at Innopolis Univeristy. Actually, I am experienced native iOS developer, and now I am learning Flutter."),
      actions: [
        OutlinedButton(
          style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
          child: const Text("Nice"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
