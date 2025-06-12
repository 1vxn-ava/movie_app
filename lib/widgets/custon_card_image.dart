import 'package:flutter/material.dart';

class CustomCardImage extends StatelessWidget {
  final String posterPath;
  const CustomCardImage({super.key, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FadeInImage(
        placeholder: AssetImage('assets/images/loading.gif'),
        image: NetworkImage(posterPath),
      ),
    );
  }
}