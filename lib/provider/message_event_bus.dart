import 'dart:convert';
import 'dart:io';

import 'package:best_flutter_ui_templates/chat/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/customer/customer_mqtt_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MessageEventBus extends ChangeNotifier {
  CustomerMqttClient? client = null;

  ChatMessage? receiverMessage;

  _initMqttClient(String socketUrl, String username) {
    client = CustomerMqttClient(socketUrl, username);

    /// Set logging on if needed, defaults to off
    client!.logging(on: false);

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client!.keepAlivePeriod = 20;

    /// Add the unsolicited disconnection callback
    client!.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client!.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client!.onSubscribed = onSubscribed;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client!.pongCallback = pong;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier(username)
        .withProtocolVersion(2)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client!.connectionMessage = connMess;
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client!.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  login(String? socketUrl, String? username, String? password) async {
    try {
      _initMqttClient(socketUrl!, username!);
      await client!.connect(username, password);
      client!.customer!.listen((MqttCustomerMessage messages) {
        _onMessage(messages);
      });
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      client!.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      client!.disconnect();
    }

    /// Check we are connected
    return client!.connectionStatus!.state == MqttConnectionState.connected;
  }

  sendCustomerMessage(ChatMessage? chatMessage) {
    final builder = MqttClientPayloadBuilder();

    builder.addUTF8String(chatMessage!.toJson());
    var message = MqttCustomerMessage(1, builder.payload);
   // var header =  MqttHeader().asType(MqttMessageType.reserved1);
    // header.qos = MqttQos.exactlyOnce;
    // message.header =  header;
    client!.sendCustomerMessage(message);
  }

  _onMessage(MqttCustomerMessage message) {
    print(utf8.decoder.convert(message.payload.message!.toList()));
    String messageString =
        utf8.decoder.convert(message.payload.message!.toList());
    receiverMessage = ChatMessage.fromJson(messageString);
    receiverMessage!.direction = 0;
    notifyListeners();
  }
}
