import 'package:flutter/material.dart';

class GameReadyScreen extends StatelessWidget {
  const GameReadyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Game Configured\nIt\'s About To Start!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Icon(
                Icons.check_circle_outline_sharp,
                color: Colors.purple,
                size: 200,
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
