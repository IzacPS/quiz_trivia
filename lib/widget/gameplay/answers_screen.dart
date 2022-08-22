import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/ad/ad_helper.dart';
import 'package:quiz_app/quiz_repository/models/question.dart';

class AnswersScreen extends StatelessWidget {
  final List<Question> questions;
  const AnswersScreen({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Answers'),
      ),
      body: SafeArea(
        child: ListView(children: configAnswersList()),
      ),
    );
  }

  List<Widget> configAnswersList() {
    List<Widget> l = [];
    int j = 0;

    for (int i = 0; i < questions.length; i++) {
      l.add(Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: ListTile(
              title: Text('${i + 1} - ${questions[i].description}',
                  style: const TextStyle(fontSize: 20)),
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (_, indexAnswers) {
                return Card(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  color: (indexAnswers == questions[i].correctAnswer)
                      ? Colors.grey[200]
                      : null,
                  elevation:
                      (indexAnswers == questions[i].correctAnswer) ? 4 : 1,
                  child: ListTile(
                    leading: (indexAnswers == questions[i].correctAnswer)
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : const Icon(null),
                    title: Text(questions[i].answers[indexAnswers].description),
                  ),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(
                    height: 8,
                  ),
              itemCount: questions[i].answers.length)
          //+ AdHelper.bannerList.length
        ],
      ));
      if (i % 3 == 0 && i != 0) {
        Widget w = (AdHelper.bannerList[j].isReady)
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: AdSize.banner.width.toDouble(),
                  height: AdSize.banner.height.toDouble(),
                  child: AdWidget(ad: AdHelper.bannerList[j].bannerAd!),
                ),
              )
            : const SizedBox.shrink();
        l.add(w);
        j++;
      }
    }
    Widget w = (AdHelper.bannerList[j].isReady)
        ? Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: AdHelper.bannerList[j].bannerAd!),
            ),
          )
        : const SizedBox.shrink();
    l.add(w);
    return l;
  }
}
