import 'package:flutter/material.dart';
import 'package:moviefy/Models/movie_model.dart';
import 'package:moviefy/Services/database_helper/database.dart';
import 'package:moviefy/Services/database_helper/service_locator.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class FavoriteIcon extends StatefulWidget {
  final Movie movie;
  FavoriteIcon(
    this.movie,
  );

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  IconData icon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    // provider.loadSearchMovie(provider.searchMovieList[widget.index].title);
    return FutureBuilder(
      future: provider.checkFavorites(widget.movie.id),
      builder: (ctx, snap) {
        // print('IsFav??????????????????????? ${snap.data}');
        return Consumer<ApiProvider>(
          builder: (context, provider, child) {
            return Flexible(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black26.withOpacity(0.2),
                ),
                child: IconButton(
                  icon: snap.data == true
                      ? Icon(
                          provider.icon = Icons.favorite,
                          color: Colors.yellowAccent,
                          // color: Colors.redAccent,
                        )
                      : Icon(provider.icon = Icons.favorite_border),
                  onPressed: () async {
                    setState(() {
                      provider.icon == Icons.favorite
                          ? provider.icon = Icons.favorite_border
                          : provider.icon = Icons.favorite;
                      // print(snap.data);
                    });

                    var db = locator<DatabaseHelper>();
                    bool isFav = await db.isFavourite(widget.movie.id);
                    if (!isFav) {
                      await db.insert({
                        "movieID": widget.movie.id,
                        "title": widget.movie.title,
                        "releaseDate": widget.movie.releaseDate,
                        "vote": widget.movie.voteAverage,
                        "backdropPath": widget.movie.backDropPath,
                        "language": widget.movie.originalLanguage
                      });
                    } else {
                      await db.delete(widget.movie.id);
                      // print('fuck you');
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  onToggle() {
    setState(() {});
  }
}
