import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //recuperar el indice o el objeto de tipo pelicula
    return Scaffold(body: CustomScrollView(slivers: [SliverAppBar()]));
  }
}
