import 'dart:convert';

MovieDetail movieDetailFromJson(String str) => MovieDetail.fromJson(json.decode(str));

String movieDetailToJson(MovieDetail data) => json.encode(data.toJson());

class MovieDetail {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  List<String> originCountry;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"]?.toString() ?? "",
    belongsToCollection: json["belongs_to_collection"],
    budget: json["budget"] ?? 0,
    genres: json["genres"] != null
        ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
        : [],
    homepage: json["homepage"]?.toString() ?? "",
    id: json["id"] ?? 0,
    imdbId: json["imdb_id"]?.toString() ?? "",
    originCountry: json["origin_country"] != null
        ? List<String>.from(json["origin_country"].map((x) => x.toString()))
        : [],
    originalLanguage: json["original_language"]?.toString() ?? "en",
    originalTitle: json["original_title"]?.toString() ?? "",
    overview: json["overview"]?.toString() ?? "",
    popularity: (json["popularity"] is num) ? (json["popularity"] as num).toDouble() : 0.0,
    posterPath: json["poster_path"]?.toString() ?? "",
    productionCompanies: json["production_companies"] != null
        ? List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x)))
        : [],
    productionCountries: json["production_countries"] != null
        ? List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x)))
        : [],
    releaseDate: json["release_date"] != null
        ? (DateTime.tryParse(json["release_date"].toString()) ?? DateTime(1900))
        : DateTime(1900),
    revenue: json["revenue"] ?? 0,
    runtime: json["runtime"] ?? 0,
    spokenLanguages: json["spoken_languages"] != null
        ? List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x)))
        : [],
    status: json["status"]?.toString() ?? "",
    tagline: json["tagline"]?.toString() ?? "",
    title: json["title"]?.toString() ?? "",
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] is num) ? (json["vote_average"] as num).toDouble() : 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": belongsToCollection,
    "budget": budget,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
    "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime,
    "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"] ?? 0,
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
    id: json["id"] ?? 0,
    logoPath: json["logo_path"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    originCountry: json["origin_country"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
    iso31661: json["iso_3166_1"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "iso_3166_1": iso31661,
    "name": name,
  };
}

class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"]?.toString() ?? "",
    iso6391: json["iso_639_1"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}
