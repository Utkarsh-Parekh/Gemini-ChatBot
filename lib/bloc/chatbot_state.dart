import 'package:flutter_chatbot/model/chatbot_model.dart';

class ChatBotState {
  final List<ChatBotModel> messages;
  final bool isLoading;
  final String error;

  ChatBotState({required this.messages, this.isLoading = false,this.error = ''});

  ChatBotState copyWith({
    List<ChatBotModel>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatBotState(
        messages: messages ?? this.messages,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error
    );
  }
}
