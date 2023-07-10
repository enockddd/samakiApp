import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postgres/postgres.dart';

class PostgresService {
  static final PostgresService _instance = PostgresService._internal();

  // Replace these with your actual PostgreSQL configuration details
  static const String _host = '127.0.0.1';
  static const int _port = 5432;
  static const String _database = 'fish_db';
  static const String _username = 'postgres';
  static const String _password = 'tish1997!';

  PostgreSQLConnection? _connection;

  factory PostgresService() {
    return _instance;
  }

  PostgresService._internal();

  Future<void> _connect() async {
    if (_connection == null || _connection!.isClosed) {
      _connection = PostgreSQLConnection(_host, _port, _database,
          username: _username, password: _password);
      await _connection!.open();
    }
  }

  Future<void> addUser(User user, String password) async {
    await _connect();

    // Extract necessary information from the User object
    final userId = user.uid;
    final userEmail = user.email;

    // Hash the password
    final passwordHash = sha256.convert(utf8.encode(password)).toString();

    // Prepare the query to insert the user data
    final query = '''
      INSERT INTO users (id, email, password_hash)
      VALUES (@id, @email, @password_hash)
    ''';

    // Execute the query and insert the user data
    await _connection!.query(query, substitutionValues: {
      'user_id': userId,
      'email': userEmail,
      'password_hash': passwordHash,
    });
  }

  // ...
  Future<void> createPost(
      String description, String postType, String mediaUrl, List<String> tags) async {
    await _connect();
    await _connection!.transaction((transaction) async {
      // Insert the post into the posts table
      final result = await transaction.query(
        'INSERT INTO posts (description, post_type, media_url) VALUES (@a, @b, @c) RETURNING id',
        substitutionValues: {'a': description, 'b': postType, 'c': mediaUrl},
      );

      // Get the id of the inserted post
      int postId = result[0][0];

      // Insert the tags into the tags table
      for (String tag in tags) {
        await transaction.execute(
          'INSERT INTO post_tags (post_id, tag) VALUES (@postId, @tag)',
          substitutionValues: {'postId': postId, 'tag': tag},
        );
      }
    });
  }
}