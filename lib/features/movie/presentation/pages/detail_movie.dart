import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/constants/app_sizes.dart';
import 'package:popular_movies/core/utils/utils.dart';
import 'package:popular_movies/core/widgets/w_custom_sliver_appbar.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';

class DetailMovie extends StatelessWidget {
  final Movie movie;
  const DetailMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          CustomSliverAppBar(size: size, movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return InfoMovie(
              movie: movie,
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}

class InfoMovie extends StatelessWidget {
  final Movie movie;
  const InfoMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    final overView = Helper.splitOverView(text: movie.overview, limit: 272);

    final isDivide = overView['isDivide'];
    final firstPart = overView['firstPart'];
    final secondPart = overView['secondPart'];

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.223,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: size.width * 0.3,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: movie.localPosterPath != null
                      ? Image.file(File(movie.localPosterPath!))
                      : Image.network(movie.posterPath),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: (size.width - 20) * 0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: textStyle.titleLarge,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          child: Text(
                            textAlign: TextAlign.justify,
                            firstPart,
                            style: textStyle.bodySmall,
                            maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isDivide)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                textAlign: TextAlign.justify,
                secondPart,
                style: textStyle.bodySmall,
                maxLines: 20,
              ),
            ),
          _Rated(movie: movie, textStyle: textStyle),

          // Container(
          //   height: 190,
          //   width: MediaQuery.of(context).size.width,
          //   margin: const EdgeInsets.symmetric(vertical: 10),
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: actors!.length,
          //       itemBuilder: (context, index) {
          //         return FlipCard(
          //           index: index,
          //           actors: actors,
          //         );
          //       }),
          // ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class _Rated extends StatelessWidget {
  const _Rated({
    required this.movie,
    required this.textStyle,
  });

  final Movie movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    log(movie.releaseDate.toString());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Promdeio de votos",
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.star_half_outlined,
                color: Color.fromARGB(255, 212, 193, 28),
              ),
              Text(
                textAlign: TextAlign.center,
                FormatNumber.number(movie.voteAverage),
                maxLines: 2,
                style: textStyle.bodyMedium
                    ?.copyWith(color: const Color.fromARGB(255, 212, 193, 28)),
              ),
            ],
          ),
          gapH12,
          Row(
            children: [
              Text(
                "Popularidad",
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
              const SizedBox(width: 65),
              Text(
                FormatNumber.number(movie.popularity),
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
            ],
          ),
          gapH12,
          Row(
            children: [
              Text(
                "Fecha de lazamiento",
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
              const SizedBox(width: 16),
              Text(
                textAlign: TextAlign.center,
                FormatNumber.formatDate(movie.releaseDate),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BannerDetail extends StatelessWidget {
  const BannerDetail({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: size.width,
      child: Row(
        children: [
          BuilderImage(
            height: 300,
            width: size.width * 0.5,
            image: movie.backdropPath,
            borderRadius: BorderRadius.circular(0),
          ),
          BuilderImage(
            height: 300,
            width: size.width * 0.5,
            image: movie.posterPath,
            borderRadius: BorderRadius.circular(0),
            withGradient: true,
          ),
        ],
      ),
    );
  }
}

class BuilderImage extends StatelessWidget {
  const BuilderImage({
    super.key,
    required this.height,
    required this.width,
    this.image,
    this.borderRadius,
    this.backgroundColor,
    this.withGradient = false,
    this.withBoxShadow = false,
    this.begin,
    this.end,
  });

  final double height;
  final double width;
  final String? image;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final bool withGradient;
  final bool withBoxShadow;
  final Alignment? begin;
  final Alignment? end;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        gradient: withGradient
            ? LinearGradient(
                begin: begin ?? Alignment.centerLeft, // Punto de inicio
                end: end ?? Alignment.centerRight, // Punto final
                colors: [
                    Colors.white, // Color inicial
                    Colors.white54, //

                    AppColors.black.withOpacity(.5), // Color final
                  ],
                stops: const [
                    0.0,
                    0.02,
                    1.0
                  ])
            : null,
        boxShadow: withBoxShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 7),
                  blurRadius: 12,
                  spreadRadius: -3,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          image ?? "",
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
        ),
      ),
    );
  }
}
