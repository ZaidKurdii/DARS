import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_page_view.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //
  final _controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //
  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'english',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(bottom: 60),
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                  color: Colors.green.shade100,
                  urlImage: 'assets/img/page1.png',
                  title: 'Welcome to DARS',
                  subtitle:
                      'Well, I can tell you a story about this. A few weeks ago, I was late to Farmers Market. As I parked my car, I received a text message. I took my eggs out of the car and was walking toward the building when I thought to look at it.'),
              buildPage(
                  color: Colors.blue.shade100,
                  urlImage: 'assets/img/page2.png',
                  title: 'Learn By Easy Way',
                  subtitle:
                      'Well, I can tell you a story about this. A few weeks ago, I was late to Farmers Market. As I parked my car, I received a text message. I took my eggs out of the car and was walking toward the building when I thought to look at it.'),
              buildPage(
                  color: Colors.orange.shade100,
                  urlImage: 'assets/img/page3.png',
                  title: 'Achive Your Goals',
                  subtitle:
                      'Well, I can tell you a story about this. A few weeks ago, I was late to Farmers Market. As I parked my car, I received a text message. I took my eggs out of the car and was walking toward the building when I thought to look at it.'),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.teal.shade700,
                  minimumSize: const Size.fromHeight(80),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPageScreen(),
                    ),
                  );
                },
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 80,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        child: Text(
                          "SKIP",
                          style: TextStyle(
                              color: Colors.teal.shade700, fontSize: 15),
                        ),
                        onPressed: () {
                          _controller.jumpToPage(2);
                        }),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.teal.shade700,
                        ),
                        onDotClicked: (index) {
                          _controller.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
                    ),
                    TextButton(
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                              color: Colors.teal.shade700, fontSize: 15),
                        ),
                        onPressed: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
