// import 'package:dio/dio.dart';
// import 'package:news_app/core/database/api/api_error_mapper.dart';
// import 'package:news_app/core/errors/failure.dart/failure.dart';
// import 'package:news_app/core/helper/result.dart';
// import 'package:news_app/core/shared/data/datasources/news_local_data_source.dart';
// import 'package:news_app/core/shared/data/datasources/news_remote_data_source.dart';
// import 'package:news_app/core/shared/domain/entities/post_entitiy.dart';
// import 'package:news_app/core/shared/domain/repositories/news_repository.dart';
// import 'package:news_app/core/shared/params/news_category_params.dart';
// import 'package:news_app/core/shared/data/mappers/article_mapper.dart';

// class NewsRepositoryImpl extends NewsRepository {
//   // final NetworkInfo networkInfo;
//   final NewsRemoteDataSource remoteDataSource;
//   final NewsLocalDataSource localDataSource;
//   NewsRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//     // required this.networkInfo,
//   });
//   //!Filtered Posts with Category\

//   @override
//   Future<Result<List<PostEntity>>> getNewsByCategory({
//     required NewsCategoryParams params,
//   }) async {
//     try {
//       final remoteNews = await remoteDataSource.getNewsByCategory(params);

//       await localDataSource.saveCategoryNews(params.category, remoteNews);

//       final articles = remoteNews.articles
//           .map((article) => ArticleMapper.toEntity(article))
//           .toList();

//       return Result.ok(articles);
//     } on DioException catch (e) {
//       final cached = localDataSource.getCategoryNews(params.category);
//       if (cached != null) {
//         final articles = cached.articles
//             .map((article) => ArticleMapper.toEntity(article))
//             .toList();

//         return Result.ok(articles);
//       }
//       return Result.error(
//         ApiErrorMapper.fromDioException(e),
//       );
//     } catch (e) {
//       return Result.error(const UnknownFailure());
//     }
//   }
// }
