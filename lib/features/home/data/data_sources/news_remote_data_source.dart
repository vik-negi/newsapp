import 'package:dartz/dartz.dart';
import 'package:news/features/home/data/models/article_model.dart';
import 'package:news/utils/constants.dart';
import 'package:news/utils/service/dio_client.dart';
import 'package:news/utils/service/failure.dart';

class NewsRemoteDataSource {
  final DioClient dioClient;

  NewsRemoteDataSource(this.dioClient);

  Future<Either<APIFailure, ArticleModelResponse>> fetchTopHeadlines(
      {String? languageCode,
      String? countryCode,
      int? page = 1,
      String? category}) async {
    Map<String, dynamic> queryParameters = {"apiKey": Constants.apiKey};
    if (languageCode != null) queryParameters["language"] = languageCode;
    if (countryCode != null) queryParameters["country"] = countryCode;
    if (category != null) queryParameters["category"] = category;

    queryParameters["page"] = page;
    return await dioClient.getRequest(
      "${Constants.baseUrl}top-headlines",
      queryParameters: queryParameters,
      fromJson: ArticleModelResponse.fromJson,
    );
  }
}
