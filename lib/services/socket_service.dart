import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomSocket {
  static final String wsUri = dotenv.env["WS_URI"] as String;
  late IOWebSocketChannel channel;
  CustomSocket(String path) {
    channel = IOWebSocketChannel.connect("ws://$wsUri/ws$path");
  }

  void disconnectFromServer() {
    print('disconnect server: ');
    channel.sink.close(status.goingAway);
  }

  void listenForMessages(void onMessageReceived(dynamic message)) {
    print("now listening for messages of ws://$wsUri/ws: ");
    channel.stream.listen(onMessageReceived);
  }

  void sendMessage(String message) {
    print('sending a message: ' + message);
    channel.sink.add(message);
  }
}
