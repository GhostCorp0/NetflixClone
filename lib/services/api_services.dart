import 'package:netlfix_clone/common/utils.dart';
import 'package:netlfix_clone/model/SearchMovie.dart';
import 'package:netlfix_clone/model/movie_detail.dart';
import 'package:netlfix_clone/model/movie_recommendation.dart';
import 'package:netlfix_clone/model/popular_tv_series.dart';
import 'package:netlfix_clone/model/top_rated_movies.dart';
import 'package:netlfix_clone/model/trending_movies.dart';
import 'package:netlfix_clone/model/upcoming_movies.dart';
import '../model/movie_model.dart';
import 'package:http/http.dart' as http;


var key ="?api_key=$apiKey";

class ApiServices {

  Future<Movie?> fetchMovies() async{
    try{
      const endPoint = "movie/now_playing";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return movieFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }

  Future<UpcomingMovies?> upcomingMovies() async{
    try{
      const endPoint = "movie/upcoming";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return upcomingMoviesFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }

  Future<TrendingMovies?> trendingMovies() async{
    try{
      const endPoint = "trending/movie/day";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return trendingMoviesFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }

  Future<TopRatedMovies?> topRatedMovies() async{
    try{
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return topRatedMoviesFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }

  Future<PopularTvSeries?> popularTvSeries() async{
    try{
      const endPoint = "tv/popular";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return popularTvSeriesFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }

  Future<MovieDetail?> movieDetail(int movieId) async{
    try{
      final endPoint = "movie/$movieId";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return movieDetailFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }

  Future<MovieRecommendation?> movieRecommendation(int movieId) async{
    try{
      final endPoint = "movie/$movieId/recommendations";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return movieRecommendationFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }

  Future<SearchMovie?> searchMovie(String query) async{
    try{
      final endPoint = "search/movie?query=$query";
      final apiUrl = "$baseUrl$endPoint";
      final response = await http.get(Uri.parse(apiUrl),headers: {
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YmJhZWI4YWM2MGUyOTU5MDM4N2M4YzU3ZWI1Y2YyMCIsIm5iZiI6MTc3MDQ5OTM1NS42ODMsInN1YiI6IjY5ODdhZDFiN2Y4YzdlYmRhNThlNjhkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NVHVoOQHP4paBAjKRmgxYX0FeVTEV4zIBaRVHm9eE9s"
      });
      if(response.statusCode == 200){
        return searchMovieFromJson(response.body);
      }else{
        throw Exception("Failed to load movies");
      }
    }catch(e) {
      print("Error fetching movies:$e");
      return null;
    }
  }
}