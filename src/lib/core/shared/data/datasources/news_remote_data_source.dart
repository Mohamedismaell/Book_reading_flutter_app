// import 'package:news_app/core/database/api/api_consumer.dart';
// import 'package:news_app/core/database/api/end_points.dart';
// import 'package:news_app/core/shared/params/news_category_params.dart';
// import 'package:news_app/core/shared/data/models/news_response_dto.dart';

// class NewsRemoteDataSource {
//   final ApiConsumer api;

//   NewsRemoteDataSource({required this.api});
//   Future<NewsResponseDto> getNewsByCategory(
//     NewsCategoryParams params,
//   ) async {
//     final response = await api.get(
//       EndPoints.allNews,
//       queryParameters: {
//         'q': params.category,
//         'apiKey': EndPoints.token,
//       },
//     );
//     return NewsResponseDto.fromJsonMap(response);
//   }

//   Future<NewsResponseDto> getTopHeadLines() async {
//     final newsCategoryRes = await api.get(
//       EndPoints.topHeadLines,
//       queryParameters: {
//         'country': EndPoints.country,
//         'apiKey': EndPoints.token,
//       },
//     );
//     return NewsResponseDto.fromJsonMap(newsCategoryRes);
//   }
// }
