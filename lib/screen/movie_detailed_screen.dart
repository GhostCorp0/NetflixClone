import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netlfix_clone/common/utils.dart';
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

  @override
  void initState() {
    fetchMovieData();
    super.initState();
  }

  void fetchMovieData() {
    movieDetail = apiServices.movieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data;
              return Column(
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
                    ],
                  ),
                ],
              );
            }
            return Text("Something Went Wrong");
          },
        ),
      ),
    );
  }
}
