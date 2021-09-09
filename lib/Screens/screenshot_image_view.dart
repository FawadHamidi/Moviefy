import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  final int index;

  ImageView(this.index);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return Hero(
        tag: 'screenshot',
        child: Center(
            child: Container(
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl:
                'https://image.tmdb.org/t/p/w500${provider.movieDetail.movieImage.backdrops[index].imagePath}',
            fit: BoxFit.cover,
          ),
        )));
  }
}
