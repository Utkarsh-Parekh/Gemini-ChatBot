import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_chatbot/bloc/chatbot_event.dart';
import 'package:flutter_chatbot/bloc/chatbot_state.dart';
import 'package:flutter_chatbot/model/chatbot_model.dart';

import '../repository/chat_repository.dart';

class ChatbotBloc extends Bloc<ChatBotEvents, ChatBotState> {
  final ChatRepository chatRepository;

  ChatbotBloc(this.chatRepository) : super(ChatBotState(messages: [])) {
    on<ChatBotReponseEvent>(_chatBotResonseEvent);
  }

  FutureOr<void> _chatBotResonseEvent(
      ChatBotReponseEvent event, Emitter<ChatBotState> emit) async {
    final userMessage = ChatBotModel(text: event.prompt!, isUser: true);

    emit(
      state.copyWith(
          isLoading: true,
          messages: [...state.messages, userMessage],
          error: ''),
    );

    try {
      final botReponse = await chatRepository.getBotResponse(event.prompt!);
      final output = ChatBotModel(text: botReponse, isUser: false);

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
