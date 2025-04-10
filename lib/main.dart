import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatbot/bloc/chatbot_bloc.dart';
import 'package:flutter_chatbot/repository/chatRepository.dart';
import 'package:flutter_chatbot/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    RepositoryProvider<ChatRepository>(
      create: (context) => ChatRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChatbotBloc(
              context.read<ChatRepository>(),
            ),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: ChatSplashScreeen());
  }
}
