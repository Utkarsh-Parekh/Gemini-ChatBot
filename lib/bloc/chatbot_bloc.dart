import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_chatbot/bloc/chatbot_event.dart';
import 'package:flutter_chatbot/bloc/chatbot_state.dart';
import 'package:flutter_chatbot/model/chatbotModel.dart';

import '../repository/chatRepository.dart';

class ChatbotBloc extends Bloc<ChatBotEvents, ChatBotState> {
  final ChatRepository chatRepository;

  ChatbotBloc(this.chatRepository) : super(ChatBotState(messages: [])) {
    on<ChatBotReponseEvent>(_chatBotResonseEvent);
  }

  FutureOr<void> _chatBotResonseEvent(
      ChatBotReponseEvent event, Emitter<ChatBotState> emit) async {
    final UserMessage = ChatBotModel(text: event.Prompt!, isUser: true);

    print("UserMessage is ${UserMessage}");
    emit(
      state.copyWith(
          isLoading: true,
          messages: [...state.messages, UserMessage],
          error: ''),
    );

    try {
      final botReponse = await chatRepository.getBotResponse(event.Prompt!);
      final output = ChatBotModel(text: botReponse, isUser: false);

      print("BotReponse is ${botReponse}");

      emit(
        state.copyWith(
          isLoading: false,
          messages: [...state.messages, output],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }
}
