import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netlfix_clone/common/utils.dart';
import 'package:netlfix_clone/model/SearchMovie.dart';
import 'package:netlfix_clone/model/trending_movies.dart';
import 'package:netlfix_clone/screen/movie_detailed_screen.dart';
import 'package:netlfix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  SearchMovie? searchMovie;
  late Future<TrendingMovies?> trendingMovie;

  void search(String query) {
    apiServices.searchMovie(query).then((result) {
      setState(() {
        searchMovie = result;
      });
    });
  }

  @override
  void initState() {
    trendingMovie = apiServices.trendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              controller: searchController,
              padding: EdgeInsets.all(10),
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              suffixIcon: Icon(Icons.cancel, color: Colors.white),
              backgroundColor: Colors.grey.withAlpha(76),
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  search(searchController.text);
                }
              },
            ),
            SizedBox(height: 10),
            searchController.text.isEmpty
                ? FutureBuilder(
                    future: trendingMovie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movie = snapshot.data?.results;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              'Top Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: movie!.length,
                              itemBuilder: (context, index) {
                                final topMovie = movie[index];
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailedScreen(
                                                    movieId: topMovie.id,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${topMovie.backdropPath}",
                                                fit: BoxFit.contain,
                                                width: 150,
                                              ),
                                              SizedBox(width: 20),
                                              Flexible(
                                                child: Text(
                                                  topMovie.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 27,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return Center(child: CircularProgressIndicator(),);
                    },
                  )
                : searchMovie == null
                ? SizedBox.shrink()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchMovie!.results.length,
                    itemBuilder: (context, index) {
                      final search = searchMovie!.results[index];
                      return search.backdropPath == null
                          ? SizedBox()
                          : Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailedScreen(
                                                movieId: search.id,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "$imageUrl${search.posterPath}",
                                            fit: BoxFit.contain,
                                            width: 150,
                                          ),
                                          SizedBox(width: 20),
                                          Flexible(
                                            child: Text(
                                              search.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
