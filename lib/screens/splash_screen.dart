import 'package:flutter/material.dart';
import 'package:flutter_chatbot/screens/chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatSplashScreeen extends StatefulWidget {
  const ChatSplashScreeen({super.key});

  @override
  State<ChatSplashScreeen> createState() => _ChatSplashScreeenState();
}

class _ChatSplashScreeenState extends State<ChatSplashScreeen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() async{

    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
    animation = Tween<double>(begin: 0.8,end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _navigateToChatScreen();
    super.initState();
  }


  void _navigateToChatScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: ScaleTransition(
            scale: animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/chatbot_splash.png',width: 200,height: 200,),

                const SizedBox(
                  height: 10,
                ),
            
                Text('AI ChatBot',style:GoogleFonts.poppins(fontSize: 30,color: Colors.blue))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
