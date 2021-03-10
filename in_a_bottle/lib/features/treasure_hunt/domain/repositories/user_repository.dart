import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/models/user.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  //} extends BaseRepository<User, String> {
  Future<String> login(User user);

  Future<User> loadByEmail(String email);
}
