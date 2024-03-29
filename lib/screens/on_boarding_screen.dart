import 'package:flutter/material.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/helpers/cache_helper.dart';
import '/screens/login_screen.dart';
import '/screens/home_screen.dart';
import '/shared/component.dart';

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
  void didChangeDependencies() {
    _onBoarding = [
      OnBoaringModel(
        imagePath: 'assets/images/iamge1.png',
        title: getTranslated(context, 'on_boaridng_title1'),
        body: getTranslated(context, 'on_boaridng_desc1'),
      ),
      OnBoaringModel(
        imagePath: 'assets/images/iamge2.png',
        title: getTranslated(context, 'on_boaridng_title2'),
        body: getTranslated(context, 'on_boaridng_desc2'),
      ),
      OnBoaringModel(
        imagePath: 'assets/images/iamge3.png',
        title: getTranslated(context, 'on_boaridng_title3'),
        body: getTranslated(context, 'on_boaridng_desc3'),
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.1),
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
                    height: screenHeight*0.3,
                    child: Image(
                      image: AssetImage('${_onBoarding[i].imagePath}'),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    '${_onBoarding[i].title}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: Text('${_onBoarding[i].body}',
                        style: TextStyle(color: Colors.grey,fontSize: 18),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: _onBoarding.length,
            effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).primaryColor),
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
                    CacheHelper.setOnboarding('onBoarding', true);
                    navAndFininsh(context, LoginScreen());
                  },
                  child: Text(
                    getTranslated(context, 'on_boaridng_skip'),
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
                      CacheHelper.setOnboarding('onBoarding', true);
                      navAndFininsh(
                        context,
                        LoginScreen(),
                      );
                    }
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    getTranslated(context, 'on_boaridng_next'),
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
