// class BaseResponse {
//   final int? totalResults;
//   final int? moreResultsAvailable;
//   final String? next;
//   final int? requestsLeft;
//   final int? warnings;

//   BaseResponse({
//     required this.totalResults,
//     required this.moreResultsAvailable,
//     required this.next,
//     required this.requestsLeft,
//     required this.warnings,
//   });

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'totalResults': totalResults,
//       'moreResultsAvailable': moreResultsAvailable,
//       'next': next,
//       'requestsLeft': requestsLeft,
//       'warnings': warnings,
//     };
//   }

//   factory BaseResponse.fromJson(Map<String, dynamic> json) {
//     return BaseResponse(
//       totalResults: json['totalResults'] != null
//           ? json['totalResults'] as int
//           : null,
//       moreResultsAvailable:
//           json['moreResultsAvailable'] != null
//           ? json['moreResultsAvailable'] as int
//           : null,
//       next: json['next'] != null
//           ? json['next'] as String
//           : null,
//       requestsLeft: json['requestsLeft'] != null
//           ? json['requestsLeft'] as int
//           : null,
//       warnings: json['warnings'] != null
//           ? json['warnings'] as int
//           : null,
//     );
//   }
// }
