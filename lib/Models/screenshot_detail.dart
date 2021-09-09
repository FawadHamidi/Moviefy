import 'package:equatable/equatable.dart';

class ScreenShot extends Equatable {
  final double aspect;
  final String imagePath;
  final int height;
  final int width;
  final String countryCode;
  final double voteAverage;
  final int voteCount;

  ScreenShot(
      {this.aspect,
      this.imagePath,
      this.height,
      this.width,
      this.countryCode,
      this.voteAverage,
      this.voteCount});

  factory ScreenShot.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return ScreenShot();
    }
    return ScreenShot(
      aspect: json['aspect_ratio'],
      imagePath: json['file_path'],
      height: json['height'],
      width: json['width'],
      countryCode: json['iso_639_1'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [aspect, imagePath, height, width, countryCode, voteAverage, voteCount];
}
