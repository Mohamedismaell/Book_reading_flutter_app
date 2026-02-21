// part of 'search_cubit.dart';

// class SearchState extends Equatable {
//   final NewsStatus searchStatus;
//   final List<PostEntity> searchResults;
//   final String? searchQuery;
//   final String? errorMessage;
//   const SearchState({
//     this.searchStatus = NewsStatus.loading,
//     this.searchQuery,
//     this.searchResults = const [],
//     this.errorMessage,
//   });

//   SearchState copyWith({
//     String? searchQuery,
//     NewsStatus? searchStatus,
//     List<PostEntity>? searchResults,
//     String? errorMessage,
//   }) {
//     return SearchState(
//       searchQuery: searchQuery ?? this.searchQuery,
//       searchStatus: searchStatus ?? this.searchStatus,
//       searchResults: searchResults ?? this.searchResults,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [searchQuery, searchStatus, searchResults, errorMessage];
// }
