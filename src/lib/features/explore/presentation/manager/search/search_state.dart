part of 'search_cubit.dart';

class SearchState extends Equatable {
  final LoadStatus searchStatus;
  final List<BookModel> searchResults;
  final String? searchQuery;
  final String? errorMessage;
  const SearchState({
    this.searchStatus = LoadStatus.initial,
    this.searchQuery,
    this.searchResults = const [],
    this.errorMessage,
  });

  SearchState copyWith({
    String? searchQuery,
    LoadStatus? searchStatus,
    List<BookModel>? searchResults,
    String? errorMessage,
  }) {
    return SearchState(
      searchQuery: searchQuery ?? this.searchQuery,
      searchStatus: searchStatus ?? this.searchStatus,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    searchQuery,
    searchStatus,
    searchResults,
    errorMessage,
  ];
}
