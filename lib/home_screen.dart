import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final Stream<String> wordsStream;
  late final Animation<double> _animation;
  late final AnimationController _controller;
  final List<String> shownWords = [];

  static const int renderNewWordMS = 1000;
  static const int animationMS = 500;

  @override
  void initState() {
    super.initState();
    List<String> rawWords = [
      "I",
      "need",
      "every",
      "new",
      "word",
      "being",
      "added",
      "to",
      "the",
      "text",
      "to",
      "animate",
      "in",
      "using",
      "a",
      "fade",
      "functionality.",
      //
      "in",
      "using",
      "a",
      "fade",
      "functionality."
    ];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: animationMS),
    );

    _animation = CurvedAnimation(
      curve: Curves.easeIn,
      parent: _controller,
    );
    wordsStream = Stream<String>.periodic(
      const Duration(milliseconds: renderNewWordMS),
      (count) {
        _controller.reset();
        _controller.forward();
        return rawWords[count];
      },
    ).take(rawWords.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: wordsStream,
        builder: (context, snapshot) {
          String shownText = "";
          if (snapshot.data != null) {
            log("snapshot data: ${snapshot.data}");
            shownText = shownWords.join(" ");
            shownWords.add(snapshot.data!);
          }
          return AnimatedContainer(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: animationMS),
            padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: shownText,
                    style: const TextStyle(color: Colors.black),
                  ),
                  if (snapshot.data != null)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: TweenAnimationBuilder(
                        tween: Tween(begin: 0, end: snapshot.data!.length),
                        duration: const Duration(milliseconds: 500),
                        builder:(_, width, __) => SizedBox(
                          // width: width * 8,
                          child: Text(
                            " ${snapshot.data!}",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
