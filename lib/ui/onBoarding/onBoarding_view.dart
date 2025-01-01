import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/ui/auth/login/login_screen.dart';
import 'package:event_planning_app/ui/onBoarding/onBoarding_items.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  static const String routeName = 'onBoarding';

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late OnBoardingItems controller;
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = OnBoardingItems(context);
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(MyAssetsManager.eventTitleImage),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: controller.items.length,
        controller: pageController,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    controller.items[index].image,
                    height: height * 0.4,
                    width: width * 0.8,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: height * 0.025),
                Text(controller.items[index].title, style: MyAppStyles.bold20Primary),
                SizedBox(height: height * 0.025),
                Text(controller.items[index].description, style: MyAppStyles.medium16Black),
              ],
            ),
          );
        },
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentPage > 0
                ? Container(
              width: width * 0.1,
              height: height * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: MyAppColors.primaryLight,
                  width: 2.0,
                ),
              ),
              child: IconButton(
                onPressed: () => pageController.previousPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                ),
                icon: const Icon(Icons.arrow_back_outlined, color: MyAppColors.primaryLight),
                padding: EdgeInsets.zero,
              ),
            )
                : SizedBox(width: width * 0.1, height: height * 0.1),
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                dotColor: themeProvider.appTheme == ThemeMode.light ? MyAppColors.blackColor : MyAppColors.whiteColor,
                activeDotColor: MyAppColors.primaryLight,
              ),
            ),
            currentPage == controller.items.length - 1
                ? Container(
              width: width * 0.1,
              height: height * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: MyAppColors.primaryLight,
                  width: 2.0,
                ),
              ),
              child: IconButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
                icon: const Icon(Icons.arrow_forward_outlined, color: MyAppColors.primaryLight),
                padding: EdgeInsets.zero,
              ),
            )
                : Container(
              width: width * 0.1,
              height: height * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: MyAppColors.primaryLight,
                  width: 2.0,
                ),
              ),
              child: IconButton(
                onPressed: () => pageController.nextPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                ),
                icon: const Icon(Icons.arrow_forward_outlined, color: MyAppColors.primaryLight),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
