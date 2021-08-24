import 'package:flutter/material.dart';
import 'package:shop_app_bloc/helpers/cache_helper.dart';
import 'package:shop_app_bloc/screens/home_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoaringModel {
  final String imagePath;
  final String title;
  final String body;

  OnBoaringModel(
      {required this.imagePath, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  late List<OnBoaringModel> _onBoarding;
  int _currentIndex = 0;
  @override
  void initState() {
    _onBoarding = [
      OnBoaringModel(
        imagePath: 'assets/images/iamge1.png',
        title: 'ONLINE CART',
        body:
            'Select and memorize your future purchase with smart online shopping cart',
      ),
      OnBoaringModel(
        imagePath: 'assets/images/iamge2.png',
        title: 'SALES AND GIFTS',
        body: 'Holiday sales. Birthday gifts. Multi choice and categories',
      ),
      OnBoaringModel(
        imagePath: 'assets/images/iamge3.png',
        title: 'CLIENT REVIEW',
        body: 'Honest feedbacks from our clients, Happy clients - happy us',
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150),
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: _onBoarding.length,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
                print(_currentIndex);
              },
              itemBuilder: (ctx, i) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: Image(
                      image: AssetImage('${_onBoarding[i].imagePath}'),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    '${_onBoarding[i].title}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: Text('${_onBoarding[i].body}',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: _onBoarding.length,
            effect: ExpandingDotsEffect(),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    minimumSize: MaterialStateProperty.all<Size>(Size(1, 1)),
                  ),
                  onPressed: () {
                    CacheHelper.setToken('onBoarding', true);
                    navAndFininsh(context, HomeScreen());
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    minimumSize: MaterialStateProperty.all<Size>(Size(1, 1)),
                  ),
                  onPressed: () {
                    if (_currentIndex == _onBoarding.length - 1) {
                      CacheHelper.setToken('onBoarding', true);
                      navAndFininsh(
                        context,
                        HomeScreen(),
                      );
                    }
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
