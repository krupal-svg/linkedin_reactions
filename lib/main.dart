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
      body: const SocialReactionCollection(
        // emojis: [
        // Emoji(gif: 'images/like.gif', png: 'images/ic_like.png', text: 'Like'),
        // Emoji(gif: 'images/love.gif', png: 'images/love2.png', text: 'Love'),
        // Emoji(gif: 'images/haha.gif', png: 'images/haha2.png', text: 'Haha'),
        // Emoji(gif: 'images/wow.gif', png: 'images/wow2.png', text: 'Wow'),
        // Emoji(gif: 'images/sad.gif', png: 'images/sad2.png', text: 'Sad'),
        // Emoji(gif: 'images/angry.gif', png: 'images/angry2.png', text: 'Angry'),
      // ]
      ),
    );
  }
}