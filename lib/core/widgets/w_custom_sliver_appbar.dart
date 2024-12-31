import 'dart:io';

import 'package:flutter/material.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/widgets/widgets.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  final Size size;

  final double? expandedHeight;
  const CustomSliverAppBar({
    super.key,
    required this.size,
    required this.movie,
    this.expandedHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.black,
        expandedHeight: expandedHeight ?? size.height * 0.75,
        foregroundColor: AppColors.white,
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          var shrinkOffset = constraints.biggest.height;

          double expandedMargin = 0.0;
          double collapsedMargin = 60.0;

          double t = (size.height * 0.5 - shrinkOffset) /
              (size.height * 0.5 - kToolbarHeight);
          t = t.clamp(0.0, 1.0);

          double currentMargin =
              collapsedMargin + (expandedMargin - collapsedMargin) * (1 - t);

          return FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              title: Container(
                margin: EdgeInsets.only(left: currentMargin),
                width: size.width,
                child: CustomText(
                  maxLines: 2,
                  text: movie.title,
                  color: AppColors.white,
                  fontSize: 18,
                  textAlign: TextAlign.start,
                ),
              ),
              background: Stack(
                children: [
                  SizedBox.expand(
                    child: ImageNetworkRender(
                      movie: movie,
                    ),
                  ),
                  const SizedBox.expand(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ],
                            stops: [
                              0.7,
                              1.0
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox.expand(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topLeft, colors: [
                          Colors.black87,
                          Colors.transparent,
                        ], stops: [
                          0.0,
                          0.3,
                        ]),
                      ),
                    ),
                  )
                ],
              ));
        }));
  }
}

class ImageNetworkRender extends StatelessWidget {
  const ImageNetworkRender({
    this.movie,
    super.key,
  });
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return movie?.localPosterPath != null
        ? Image.file(File(movie!.localPosterPath!))
        : Image.network(
            movie?.posterPath ?? "",
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      )
                    ],
                  ),
                );
              }

              return AnimatedEntryWidget(
                  type: AnimationType.fadeIn, child: child);
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text('Error al cargar la imagen',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            },
          );
  }
}
