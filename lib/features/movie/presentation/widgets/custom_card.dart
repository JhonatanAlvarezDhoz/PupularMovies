import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/constants/app_sizes.dart';
import 'package:popular_movies/core/services/conectivity_service.dart';
import 'package:popular_movies/core/widgets/custom_text.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.movie,
    required this.constraints,
  });

  final Movie movie;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(
        '/base/movies/detailsMovie',
        extra: movie,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        height: constraints.maxHeight * 0.19,
        width: constraints.maxWidth * 0.8,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(7, 0),
                blurRadius: 12,
                spreadRadius: -5,
              )
            ]),
        child: Column(
          children: [
            Row(
              children: [
                ImageBuilder(movie: movie),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  height: 80,
                  width: (constraints.maxWidth * 0.8) - 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: movie.title,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                      ),
                      gapH8,
                      CustomText(
                        text: movie.overview == ""
                            ? "Sin descrpcion"
                            : movie.overview,
                        maxLines: 3,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      gapH8,
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.movie,
    this.height,
    this.width,
  });

  final Movie movie;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final connectivityService = ConnectivityService(Connectivity());

    return Container(
      height: height ?? 90,
      width: width ?? 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 7),
            blurRadius: 12,
            spreadRadius: -3,
          ),
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FutureBuilder(
              future: connectivityService.isConnectedToInternet(),
              builder: (context, snapShot) {
                if (!snapShot.hasData) {
                  return const SizedBox.shrink();
                }

                if (snapShot.data!) {
                  return Image.network(
                    movie.backdropPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    },
                  );
                }
                return Image.file(
                  File(movie.localBackdropPath!),
                  fit: BoxFit.cover,
                );
              })),
    );
  }
}
