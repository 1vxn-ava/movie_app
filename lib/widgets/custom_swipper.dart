import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/widgets.dart';

class CustomSwipper extends StatelessWidget {
  final List<Movie> movies;
  const CustomSwipper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.54,
      child: Swiper(
        onTap:
            (index) =>
                Navigator.pushNamed(context, 'details', arguments: 'la peli'),
        itemBuilder: (context, index) {
          return CustomCardImage(posterPath: movies[index].getPosterPath,);
        },
        itemCount: movies.length,
        itemWidth: 300,
        autoplay: false,
        control: SwiperControl(),
        layout: SwiperLayout.STACK,
      ),
    );
  }
}