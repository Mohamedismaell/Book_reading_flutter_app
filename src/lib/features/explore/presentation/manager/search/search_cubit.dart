// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:news_app/core/connection/refresh_on_reconnect.dart';
// import 'package:news_app/core/enums/stats.dart';
// import 'package:news_app/core/shared/domain/entities/post_entitiy.dart';
// import 'package:news_app/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
// import 'package:news_app/core/shared/params/news_category_params.dart';
// import 'package:news_app/features/home/domain/usecases/search_category.dart';

// part 'search_state.dart';

// class SearchCubit extends Cubit<SearchState> with RefreshOnReconnect {
//   SearchCubit(this.searchUseCase, this._connectionCubit)
//       : super(SearchState()) {
//     // init();
//     reconnect(_connectionCubit, () {
//       // init();
//     });
//   }
//   final SearchUseCase searchUseCase;
//   final AppConnectionCubit _connectionCubit;
//   Timer? _debounce;
//   // Future<void> init() async {
//   //   await search(state.searchQuery!);
//   // }

//   Future<void> search(String query) async {
//     if (_debounce?.isActive ?? false) {
//       _debounce!.cancel();
//     }
//     _debounce = Timer(Duration(milliseconds: 300), () async {
//       if (query.isEmpty) {
//         emit(state.copyWith(searchStatus: NewsStatus.initial));
//         return;
//       }
//       emit(
//           state.copyWith(searchStatus: NewsStatus.loading, searchQuery: query));
//       final response =
//           await searchUseCase.call(NewsCategoryParams(category: query));
//       response.when(
//         success: (posts) {
//           emit(
//             state.copyWith(
//               searchStatus: NewsStatus.loaded,
//               searchResults: posts,
//             ),
//           );
//         },
//         failure: (errorMessage) {
//           emit(
//             state.copyWith(
//               searchStatus: NewsStatus.error,
//               errorMessage: errorMessage.message,
//             ),
//           );
//         },
//       );
//     });
//   }

//   // @override
//   // Future<void> close() {
//   //   _debounce?.cancel();
//   //   disposeReconnect();
//   //   return super.close();
//   // }
// }
