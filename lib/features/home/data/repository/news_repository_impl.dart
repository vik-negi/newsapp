import 'package:dartz/dartz.dart';
import 'package:news/features/home/data/data_sources/news_remote_data_source.dart';
import 'package:news/features/home/data/models/article_model.dart';
import 'package:news/features/home/domain/repository/news_repository.dart';
import 'package:news/utils/service/failure.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsRemoteDataSource _remoteDataSource;

  NewsRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<APIFailure, ArticleModelResponse>> fetchTopHeadlines(
      {String? languageCode,
      String? countryCode,
      int? page = 1,
      String? category}) async {
    return _remoteDataSource.fetchTopHeadlines(
      languageCode: languageCode,
      countryCode: countryCode,
      page: page,
      category: category,
    );
  }
}
