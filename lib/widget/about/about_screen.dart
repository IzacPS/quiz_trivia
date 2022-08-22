import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'About the app',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'This is just a simple app to test the knowledge of the player '
                'about trivia questions. One of the intentions of the app is to '
                'improve the developer\'s skills. When you start the game, the '
                'player is able to choose the level of the questions, the '
                'category in a list of them and the number of questions. The '
                'player then waits for the game to be configured and a timer '
                'will start. When the timer expires, the game starts. At the end, '
                'the player can see the correct answers of the questions or redo '
                'the questions. As described, it\'s just a simple app for now. '
                'Hope the player enjoys it. :)',
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'The Trivia API',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Credits given to The Trivia API for providing the questions.'
                'The Trivia API is  a free to use API for multiple choice trivia'
                'questions. Featuring procedurally generated and user generated '
                ' questions.',
                textAlign: TextAlign.justify,
              ),
              Linkify(
                text: 'For more information visit https://the-trivia-api.com',
                linkStyle: TextStyle(color: Colors.purple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
