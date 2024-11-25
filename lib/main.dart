import 'package:example/social_reactions.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reaction',
      theme: ThemeData(primaryColor: const Color(0xff3b5998)),
      debugShowCheckedModeBanner: false,
      home: const SocialReactionMainPage(),
    );
  }
}

class SocialReactionMainPage extends StatelessWidget {
  const SocialReactionMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Social Feed Reaction ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SocialReactionCollection(
      //   reactions: [
      //   ReactionData(label: "Cry", reactionIconText: "🥲"),
      //   ReactionData(label: "Smile", reactionIconText: "😄"),
      //   ReactionData(label: "Frozen", reactionIconText: "🥶"),
      // ],
      ),
    );
  }
}