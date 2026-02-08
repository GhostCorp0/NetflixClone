import 'dart:convert';

TrendingMovies trendingMoviesFromJson(String str) => TrendingMovies.fromJson(json.decode(str));

String trendingMoviesToJson(TrendingMovies data) => json.encode(data.toJson());

class TrendingMovies {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TrendingMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingMovies.fromJson(Map<String, dynamic> json) => TrendingMovies(
    page: json["page"] ?? 1,
    results: json["results"] != null
        ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
        : [],
    totalPages: json["total_pages"] ?? 0,
    totalResults: json["total_results"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  bool adult;
  String backdropPath;
  int id;
  String title;
  String originalTitle;
  String overview;
  String posterPath;
  MediaType mediaType;
  OriginalLanguage originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"]?.toString() ?? "",
    id: json["id"] ?? 0,
    title: json["title"]?.toString() ?? "",
    originalTitle: json["original_title"]?.toString() ?? "",
    overview: json["overview"]?.toString() ?? "",
    posterPath: json["poster_path"]?.toString() ?? "",
    mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.OTHER,
    originalLanguage: originalLanguageValues.map[json["original_language"]] ?? OriginalLanguage.OTHER,
    genreIds: json["genre_ids"] != null
        ? List<int>.from((json["genre_ids"] as List).map((x) => x is int ? x : int.tryParse(x.toString()) ?? 0))
        : [],
    popularity: (json["popularity"] is num) ? (json["popularity"] as num).toDouble() : 0.0,
    releaseDate: json["release_date"] != null
        ? (DateTime.tryParse(json["release_date"].toString()) ?? DateTime(1900))
        : DateTime(1900),
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] is num) ? (json["vote_average"] as num).toDouble() : 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum MediaType {
  MOVIE,
  TV,
  OTHER
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV,
  "other": MediaType.OTHER,
});

enum OriginalLanguage {
  EN,
  FR,
  JA,
  ZH,
  KO,
  ES,
  DE,
  TR,
  PT,
  IT,
  RU,
  OTHER
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "fr": OriginalLanguage.FR,
  "ja": OriginalLanguage.JA,
  "zh": OriginalLanguage.ZH,
  "ko": OriginalLanguage.KO,
  "es": OriginalLanguage.ES,
  "de": OriginalLanguage.DE,
  "tr": OriginalLanguage.TR,
  "pt": OriginalLanguage.PT,
  "it": OriginalLanguage.IT,
  "ru": OriginalLanguage.RU,
  "other": OriginalLanguage.OTHER,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
