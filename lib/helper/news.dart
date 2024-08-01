import 'dart:convert';
import 'package:news_api/models/artical_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=e9785ebba6ff4c6cada85315976e3efb";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == "ok") {
          jsonData["articles"].forEach((element) {
            if (element["urlToImage"] != null && element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                author: element["author"] ?? 'Unknown',
                title: element["title"] ?? 'No Title',
                description: element["description"] ?? 'No Description',
                url: element["url"] ?? '',
                urlToImage: element["urlToImage"] ?? '',
                content: element["content"] ?? '',
                publishedAt: element["publishedAt"] ?? '',
              );
              news.add(articleModel);
            }
          });
        }
      } else {
        print('API isteği başarısız oldu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }
}
