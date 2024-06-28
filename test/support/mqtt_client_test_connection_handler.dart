/*
 * Package : mqtt5_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/05/2020
 * Copyright :  S.Hamblett
 */
import 'dart:async';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';

class TestConnectionHandlerNoSend extends MqttServerConnectionHandler {
  TestConnectionHandlerNoSend(var clientEventBus, {int? maxConnectionAttempts})
      : super(clientEventBus, maxConnectionAttempts: maxConnectionAttempts);

  /// Auto reconnect callback
  @override
  AutoReconnectCallback? onAutoReconnect;

  /// Use a websocket rather than TCP
  @override
  bool useWebSocket = false;

  // Server name, needed for auto reconnect.
  @override
  String? server;

  // Port number, needed for auto reconnect.
  @override
  int? port;

  /// Auto reconnect in progress
  @override
  bool? autoReconnectInProgress = false;

  // Connection message, needed for auto reconnect.
  @override
  MqttConnectMessage? connectionMessage;

  /// Alternate websocket implementation.
  ///
  /// The Amazon Web Services (AWS) IOT MQTT interface(and maybe others)
  /// has a bug that causes it not to connect if unexpected message headers are
  /// present in the initial GET message during the handshake.
  /// Since the httpclient classes insist on adding those headers, an alternate
  /// method is used to perform the handshake.
  /// After the handshake everything goes back to the normal websocket class.
  /// Only use this websocket implementation if you know it is needed
  /// by your broker.
  @override
  bool useAlternateWebSocketImplementation = false;

  /// User supplied websocket protocols
  @override
  List<String>? websocketProtocols;

  /// If set use a secure connection, note TCP only, not websocket.
  @override
  bool secure = false;

  /// The security context for secure usage
  @override
  dynamic securityContext;

  /// Successful connection callback
  @override
  ConnectCallback? onConnected;

  /// Unsolicited disconnection callback
  @override
  DisconnectCallback? onDisconnected;

  /// Callback function to handle bad certificate. if true, ignore the error.
  @override
  bool Function(dynamic certificate)? onBadCertificate;

  @override
  Future<MqttConnectionStatus> internalConnect(
      String? hostname, int? port, MqttConnectMessage? message) {
    final completer = Completer<MqttConnectionStatus>();
    return completer.future;
  }

  @override
  MqttConnectionState disconnect() =>
      connectionStatus.state = MqttConnectionState.disconnected;
}

class TestConnectionHandlerSend extends MqttServerConnectionHandler {
  TestConnectionHandlerSend(var clientEventBus, {int? maxConnectionAttempts})
      : super(clientEventBus, maxConnectionAttempts: maxConnectionAttempts);
  // Server name, needed for auto reconnect.
  @override
  String? server;

  // Port number, needed for auto reconnect.
  @override
  int? port;

  // Connection message, needed for auto reconnect.
  @override
  MqttConnectMessage? connectionMessage;

  /// Auto reconnect in progress
  @override
  bool? autoReconnectInProgress = false;

  /// Use a websocket rather than TCP
  @override
  bool useWebSocket = false;

  /// Auto reconnect callback
  @override
  AutoReconnectCallback? onAutoReconnect;

  /// Alternate websocket implementation.
  ///
  /// The Amazon Web Services (AWS) IOT MQTT interface(and maybe others)
  /// has a bug that causes it not to connect if unexpected message headers are
  /// present in the initial GET message during the handshake.
  /// Since the httpclient classes insist on adding those headers, an alternate
  /// method is used to perform the handshake.
  /// After the handshake everything goes back to the normal websocket class.
  /// Only use this websocket implementation if you know it is needed
  /// by your broker.
  @override
  bool useAlternateWebSocketImplementation = false;

  /// User supplied websocket protocols
  @override
  List<String>? websocketProtocols;

  /// If set use a secure connection, note TCP only, not websocket.
  @override
  bool secure = false;

  /// The security context for secure usage
  @override
  dynamic securityContext;

  /// Successful connection callback
  @override
  ConnectCallback? onConnected;

  /// Unsolicited disconnection callback
  @override
  DisconnectCallback? onDisconnected;

  /// Callback function to handle bad certificate. if true, ignore the error.
  @override
  bool Function(dynamic certificate)? onBadCertificate;
  List<MqttMessage> sentMessages = <MqttMessage>[];

  @override
  Future<MqttConnectionStatus> internalConnect(
      String? hostname, int? port, MqttConnectMessage? message) {
    final completer = Completer<MqttConnectionStatus>();
    return completer.future;
  }

  @override
  MqttConnectionState disconnect() =>
      connectionStatus.state = MqttConnectionState.disconnected;

  @override
  void sendMessage(MqttMessage message) {
    sentMessages.add(message);
  }
}
