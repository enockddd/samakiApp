// import 'dart:async';
//
// import 'package:redis/redis.dart';
//
// class RedisService {
//   static final RedisService _singleton = RedisService._internal();
//   late RedisConnection _connection;
//   late Command _command;
//
//   factory RedisService() {
//     return _singleton;
//   }
//
//   RedisService._internal();
//
//   Future<void> connect({required String host, int port = 6379}) async {
//     final connection = await RedisConnection().connect(host, port);
//     _command = connection;
//   }
//
//   Future<void> close() async {
//     await _connection.close();
//   }
//
//   Future<String?> get(String key) async {
//     return await _command.get(key);
//   }
//
//   Future<void> set(String key, String value) async {
//     await _command.set(key, value);
//   }
//
// // Add more methods as needed to interact with Redis...
// // Caching
//   Future<void> cacheData(String key, String value) async {
//     await _command.send_object(["SET", key, value]);
//   }
//
//   Future<String?> getCachedData(String key) async {
//     return await _command.send_object(["GET", key]);
//   }
//
//   // User session management
//   Future<void> storeUserSession(String sessionId, String userData) async {
//     await _command.send_object(["SET", sessionId, userData]);
//   }
//
//   Future<String?> getUserSession(String sessionId) async {
//     return await _command.send_object(["GET", sessionId]);
//   }
//
//
//   // Real-time communication
//   Future<void> publishMessage(String channel, String message) async {
//     await _command.send_object(["PUBLISH", channel, message]);
//   }
//
//   // Rate limiting
//   Future<int> incrementApiCallCounter(String userId) async {
//     return await _command.send_object(["INCR", "api_calls:$userId"]);
//   }
//
//
//   Future<bool> hasExceededRateLimit(String userId, int limit) async {
//     int apiCalls = await _command.send_object(["GET", "api_calls:$userId"]);
//     return apiCalls > limit;
//   }
//
//   // Leaderboards and counters
//   Future<void> incrementCounter(String counterKey) async {
//     await _command.send_object(["INCR", counterKey]);
//   }
//
//   Future<int> getCounterValue(String counterKey) async {
//     return await _command.send_object(["GET", counterKey]);
//   }
//
//   // Future<StreamSubscription> subscribeToChannel(String channel, Function(String, String) onMessage) async {
//   //   final pubsubClient = await Client.connect('${_client.address.host}:${_client.address.port}');
//   //   final pubsubCommand = pubsubClient.command();
//   //   await pubsubCommand.send_object(["SUBSCRIBE", channel]);
//   //   return pubsubClient.stream.listen((data) {
//   //     if (data[0] == "message") {
//   //       onMessage(data[1], data[2]);
//   //     }
//   //   });
//   // }
// }