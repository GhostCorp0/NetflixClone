import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netlfix_clone/common/utils.dart';
import 'package:netlfix_clone/model/tmdb_trending.dart';
import 'package:netlfix_clone/services/api_services.dart';

import 'movie_detailed_screen.dart';

class HotNews extends StatefulWidget {
  const HotNews({super.key});

  @override
  State<HotNews> createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  final ApiServices apiServices = ApiServices();
  late Future<TmdbTrending?> tmdbTrendingApi;

  @override
  void initState() {
    tmdbTrendingApi = apiServices.tmdbTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getShortName(String name) {
      return name.length > 3 ? name.substring(0, 3) : name;
    }

    String formatDate(String apiDate) {
      DateTime parsedDate = DateTime.parse(apiDate);
      return DateFormat("MMMM").format(parsedDate);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Hot News"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: tmdbTrendingApi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!.results;
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: movies.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  String firstAirDate =
                      movie.firstAirDate?.day.toString() ?? "";
                  String releaseDay = movie.releaseDate?.day.toString() ?? "";
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailedScreen(movieId: movie.id),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  movie.releaseDate == null
                                      ? firstAirDate
                                      : releaseDay,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  movie.releaseDate == null
                                      ? getShortName(
                                          formatDate(
                                            movie.firstAirDate?.toString() ??
                                                "",
                                          ),
                                        )
                                      : getShortName(
                                          formatDate(
                                            movie.releaseDate?.toString() ?? "",
                                          ),
                                        ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        "$imageUrl${movie.backdropPath}",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Coming on ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      movie.releaseDate == null
                                          ? firstAirDate
                                          : releaseDay,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      movie.releaseDate == null
                                          ? getShortName(
                                              formatDate(
                                                movie.firstAirDate
                                                        ?.toString() ??
                                                    "",
                                              ),
                                            )
                                          : getShortName(
                                              formatDate(
                                                movie.releaseDate?.toString() ??
                                                    "",
                                              ),
                                            ),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  movie.overview,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 15,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text("Problem to fetch data"));
          }
        },
      ),
    );
  }
}
