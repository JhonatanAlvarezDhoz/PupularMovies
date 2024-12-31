import 'package:flutter/material.dart';
import 'package:popular_movies/core/utils/responsive.dart';
import 'package:popular_movies/core/widgets/widgets.dart';
import 'package:popular_movies/features/favorite/presentation/pages/favorites_page.dart';
import 'package:popular_movies/features/movie/presentation/pages/movies.dart';
import 'package:popular_movies/features/profile/presentation/pages/profile_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset(
            "assets/icons/icon.png",
            width: 60,
          ),
        ),
        title: CustomText(
          text: "Popular Movies",
          fontWeight: FontWeight.w500,
          fontSize: 19,
        ),
        actions: [
          SizedBox(
            width: Responsive.of(context).widthResponsive(14),
          )
        ],
      ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: MoviePage(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: FavoritePage(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onChange: _onTabTapped,
        ),
      ),
    );
  }
}
