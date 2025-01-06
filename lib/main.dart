import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/events_list_provider.dart';
import 'package:event_planning_app/ui/auth/forget_password/forget_password_screen.dart';
import 'package:event_planning_app/ui/auth/login/login_screen.dart';
import 'package:event_planning_app/ui/auth/register/register_screen.dart';
import 'package:event_planning_app/ui/home_screen/home_screen.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/create_event/create_event_screen.dart';
import 'package:event_planning_app/ui/onBoarding/onBoarding_view.dart';
import 'package:event_planning_app/ui/onBoarding/start_screen.dart';
import 'package:event_planning_app/utils/myAppThemes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();  // offline
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
      ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ChangeNotifierProvider(create: (context)=>EventsListProvider())
    ],
      child: MyApp())
  );
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      initialRoute: LoginScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        OnboardingView.routeName: (context) => OnboardingView(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateEventScreen.routeName: (context) => CreateEventScreen()
      },
    );
  }
}