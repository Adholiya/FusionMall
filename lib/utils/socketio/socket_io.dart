import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  IO.Socket? _socket_live_stream;

  //live stream controller
  final StreamController<Image> _videoStreamController =
      StreamController<Image>.broadcast();

  Stream<Image> get videoStream => _videoStreamController.stream;

//function to check socket connection
  bool checkConnectionStatus() {
    return _socket_live_stream!.connected;
  }

  Future<void> connect() async {
    print("trying to connect to server");
    String server_url = "http://192.168.1.7:3000";

    try {
      print('yoooooo');
      _socket_live_stream = IO.io(
          server_url,
          IO.OptionBuilder().setTransports(['websocket', 'polling'])
              // .setTimeout(2000)
              // .disableAutoConnect()
              .build());
    } catch (e) {
      print('noooo');
      print(e);
    }

    _socket_live_stream!.onConnect((_) => print("Connected !!"));
    _socket_live_stream!.onDisconnect((_) => print("Disconnected !!"));
    _socket_live_stream?.onError((er) {
      print(er.toString());
    });
    //receiver
    _socket_live_stream!.on('receive', (data) {
      final image = Image.memory(
        base64.decode(data),
        fit: BoxFit.cover,
        gaplessPlayback: true,
        excludeFromSemantics: true,
      );
      _videoStreamController.add(image);
    });
    //sender
  }

  void sendFrame(String img) {
    // try {
      _socket_live_stream!.emit('signal', img);
    // } catch (e) {}
    print('signal sent');
  }

  void disconnect() {
    _socket_live_stream!.disconnect();
  }
}
