import 'package:equatable/equatable.dart';

abstract class ChatBotEvents extends Equatable{}


class ChatBotReponseEvent extends ChatBotEvents{
  final String? Prompt;

  ChatBotReponseEvent(this.Prompt);

  @override
  List<Object?> get props => [Prompt];

}