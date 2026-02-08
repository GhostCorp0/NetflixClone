import 'dart:convert';

TmdbTrending tmdbTrendingFromJson(String str) => TmdbTrending.fromJson(json.decode(str));

String tmdbTrendingToJson(TmdbTrending data) => json.encode(data.toJson());

class TmdbTrending {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TmdbTrending({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbTrending.fromJson(Map<String, dynamic> json) => TmdbTrending(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
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
  String? name;
  String? originalName;
  String overview;
  String posterPath;
  MediaType mediaType;
  String originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime? firstAirDate;
  double voteAverage;
  int voteCount;
  List<String>? originCountry;
  String? title;
  String? originalTitle;
  DateTime? releaseDate;
  bool? video;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    this.name,
    this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    this.originCountry,
    this.title,
    this.originalTitle,
    this.releaseDate,
    this.video,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    originalLanguage: json["original_language"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
    title: json["title"],
    originalTitle: json["original_title"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "name": name,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "original_language": originalLanguage,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
    "title": title,
    "original_title": originalTitle,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "video": video,
  };
}

enum MediaType {
  MOVIE,
  TV
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV
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
