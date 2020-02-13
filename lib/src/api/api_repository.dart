import 'package:news_app/src/api/api_provider.dart';
import 'package:news_app/src/model/category/top_headlines_news/response_top_headlines_news.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<ResponseTopHeadlinesNews> fetchTopHeadlinesNews() =>
      _apiProvider.getTopHeadLinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopBusinessHeadlinesNews() =>
      _apiProvider.getTopBusinessHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopEntertainmentHeadlinesNews() =>
      _apiProvider.getTopEntertainmentHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopHealthHeadlinesNews() =>
      _apiProvider.getTopHealthHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopScienceHeadlinesNews() =>
      _apiProvider.getTopScienceHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopSportHeadlinesNews() =>
      _apiProvider.getTopSportHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopTechnologyHeadlinesNews() =>
      _apiProvider.getTopTechnologyHeadlinesNews();
}
