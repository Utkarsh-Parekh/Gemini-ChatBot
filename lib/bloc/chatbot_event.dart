import 'package:equatable/equatable.dart';

abstract class ChatBotEvents extends Equatable{}


class ChatBotReponseEvent extends ChatBotEvents{
  final String? prompt;

  ChatBotReponseEvent(this.prompt);

  @override
  List<Object?> get props => [prompt];

}