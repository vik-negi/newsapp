import 'package:dartz/dartz.dart';
import 'package:news/features/home/data/models/article_model.dart';
import 'package:news/utils/service/failure.dart';

abstract class NewsRepository {
  Future<Either<APIFailure, ArticleModelResponse>> fetchTopHeadlines(
      {String? languageCode,
      String? countryCode,
      int? page = 1,
      String? category});
}
