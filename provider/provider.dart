import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uts_2/models/news.dart';

class NewsProvider with ChangeNotifier {
  List<News> _newsList = [];

  List<News> get newsList => _newsList;

  Future<void> fetchNews() async {
    await dotenv.load(); // Muat file .env

    final apiKey = dotenv.env['e8db554e436b4414b448a3c853aba37b']; 

    final url = Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=e8db554e436b4414b448a3c853aba37b'); 
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $apiKey', // Gunakan kunci API dalam request header
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _newsList = responseData.map((data) => News.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
