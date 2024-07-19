import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news/features/home/data/data_sources/news_remote_data_source.dart';
import 'package:news/features/home/data/repository/news_repository_impl.dart';
import 'package:news/utils/service/dio_client.dart';

final getIt = GetIt.instance;

Future<void> initializeServices() async {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(DioClient());
  getIt.registerFactory(
    () => NewsRemoteDataSource(
      getIt<DioClient>(),
    ),
  );
  getIt.registerFactory(
    () => NewsRepositoryImpl(
      getIt<NewsRemoteDataSource>(),
    ),
  );
}
