import 'package:equatable/equatable.dart';
import 'package:moviefy/Models/screenshot_detail.dart';

class MovieImage extends Equatable {
  final List<ScreenShot> backdrops;
  final List<ScreenShot> posters;

  const MovieImage({this.backdrops, this.posters});

  factory MovieImage.fromJson(Map<String, dynamic> result) {
    if (result == null) {
      return MovieImage();
    }

    return MovieImage(
      backdrops: (result['backdrops'] as List)
              ?.map((e) => ScreenShot.fromJson(e))
              ?.toList() ??
          List.empty(),
      posters: (result['posters'] as List)
              ?.map((e) => ScreenShot.fromJson(e))
              ?.toList() ??
          List.empty(),
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [backdrops, posters];
}
