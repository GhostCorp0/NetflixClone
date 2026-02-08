import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netlfix_clone/common/utils.dart';
import 'package:netlfix_clone/model/movie_recommendation.dart';
import 'package:netlfix_clone/services/api_services.dart';

import '../model/movie_detail.dart';

class MovieDetailedScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailedScreen({super.key, required this.movieId});

  @override
  State<MovieDetailedScreen> createState() => _MovieDetailedScreenState();
}

class _MovieDetailedScreenState extends State<MovieDetailedScreen> {
  final ApiServices apiServices = ApiServices();
  late Future<MovieDetail?> movieDetail;
  late Future<MovieRecommendation?> movieRecommendation;

  @override
  void initState() {
    fetchMovieData();
    super.initState();
  }

  void fetchMovieData() {
    movieDetail = apiServices.movieDetail(widget.movieId);
    movieRecommendation = apiServices.movieRecommendation(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    String formatRunTime(int runTime) {
      int hours = runTime ~/ 60;
      int minutes = runTime % 60;

      return '${hours}h ${minutes}m';
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data!;
              String genresText = movie.genres
                  .map((genre) => genre.name)
                  .join(", ");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "$imageUrl${movie?.posterPath}",
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 50,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: GestureDetector(
                                onTap: Navigator
                                    .of(context)
                                    .pop,
                                child: Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: GestureDetector(
                                child: Icon(Icons.cast, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 100,
                        bottom: 100,
                        right: 100,
                        left: 100,
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              movie!.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Image.asset("assets/symbol.png", height: 35),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              formatRunTime(movie.runtime),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "HD",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow, color: Colors.black),
                          Text(
                            "Play",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download, color: Colors.white),
                          Text(
                            "Download",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    genresText,
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                  Text(
                    movie.overview,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.add, size: 45, color: Colors.white),
                          Text(
                            "My List",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.thumb_up, size: 40, color: Colors.white),
                          Text(
                            "Rate",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.share, size: 40, color: Colors.white),
                          Text(
                            "Share",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FutureBuilder(
                    future: movieRecommendation,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movie = snapshot.data;
                        return movie!.results.isEmpty
                            ? SizedBox()
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'More Like This',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection:Axis.horizontal ,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right:5),
                                    child: CachedNetworkImage(
                                      imageUrl: "$imageUrl${movie.results[index]
                                          .posterPath}",
                                      height: 200,
                                      width: 150,
                                      fit: BoxFit.cover),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return Text("Something Went Wrong");
                    },
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
