import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Preparing Game!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              SpinKitRing(
                size: 200,
                color: Colors.purple,
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
