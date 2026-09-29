import 'package:camera/camera.dart';
import 'package:dating/Logic/cubits/Home_cubit/home_cubit.dart';
import 'package:dating/Logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:dating/Logic/cubits/editProfile_cubit/editprofile_cubit.dart';
import 'package:dating/Logic/cubits/language_cubit/language_bloc.dart';
import 'package:dating/Logic/cubits/match_cubit/match_cubit.dart';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_cubit.dart';
import 'package:dating/Logic/cubits/litedark/lite_dark_cubit.dart';
import 'package:dating/core/routes.dart';
import 'package:dating/firebase_options.dart';
import 'package:dating/language/localization/app_localization_setup.dart';
import 'package:dating/presentation/firebase/auth_firebase.dart';
import 'package:dating/presentation/firebase/chat_service.dart';
import 'package:dating/presentation/firebase/chatting_provider.dart';
import 'package:dating/presentation/firebase/pickup_callpage.dart';
import 'package:dating/presentation/firebase/vc_provider.dart';
import 'package:dating/presentation/screens/AudioCall/audiocall_provider.dart';
import 'package:dating/presentation/screens/BottomNavBar/chats.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/BottomNavBar/match/matchprovider.dart';
import 'package:dating/presentation/screens/other/editProfile/editprofile_provider.dart';
import 'package:dating/presentation/screens/other/likeMatch/likematch_provider.dart';
import 'package:dating/presentation/screens/other/premium/premium_provider.dart';
import 'package:dating/presentation/screens/other/profileAbout/detailprovider.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_page.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_provider.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/screens/splash_bording/splash_screen.dart';
import 'package:dating/wallete_code/wallet_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Logic/cubits/litedark/lite_dark_state.dart';
import 'Logic/cubits/premium_cubit/premium_bloc.dart';
import 'by_coin_screen/coin_provider.dart';

Future<void> main() async {

  // Initialize Flutter engine before using plugins
  WidgetsFlutterBinding.ensureInitialized();

  // ==========================
  // CAMERA INITIALIZATION
  // ==========================
  // Gets all available cameras (front/back)
  cameras = await availableCameras();

  // ==========================
  // GOOGLE ADMOB
  // ==========================
  // Initializes Google Mobile Ads SDK
  await MobileAds.instance.initialize();

  // ==========================
  // FIREBASE INITIALIZATION
  // ==========================

  print("Firebase Apps: ${Firebase.apps.length}");

  try {

    // Initialize Firebase only if it hasn't already been initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    print("Firebase initialized successfully");
    print(Firebase.app().name);

  } catch (e, s) {

    // Print Firebase initialization errors
    print("Firebase Error: $e");
    print(s);

  }

  // ==========================
  // FIREBASE CLOUD MESSAGING
  // ==========================

  // Handles notifications when app is in background or terminated
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  // Handles notifications when app is open
  FirebaseMessaging.onMessage.listen((event) {

    // Video Call Notification
    if (event.data["vcId"] != null) {

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => PickUpCall(
            userData: event.data,
            isAudio: false,
          ),
        ),
      );

    }

    // Audio Call Notification
    else if (event.data["Audio"] != null) {

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => PickUpCall(
            userData: event.data,
            isAudio: true,
          ),
        ),
      );

    }

  });

  // ==========================
  // SHARED PREFERENCES
  // ==========================

  // Local storage for saving small values
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Save default value
  await prefs.setDouble("rediuse", 0);

  // ==========================
  // LOCAL NOTIFICATIONS
  // ==========================

  // Initialize notification plugin
  initializeNotifications();

  // Listen for Firebase notifications
  listenFCM();

  // Load FCM Token & Notification Permission
  loadFCM();

  // ==========================
  // START APPLICATION
  // ==========================

  runApp(MyApp());

}

// Global navigator key used to navigate without BuildContext
final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(

      providers: [

        // Controls Light/Dark Theme
        BlocProvider(create: (context) => ThemeBloc()),

        // Login / Signup
        BlocProvider(create: (context) => AuthCubit()),

        // Onboarding Screens
        BlocProvider(create: (context) => OnbordingCubit()),

        // Home Screen Logic
        BlocProvider(create: (context) => HomePageCubit()),

        // Edit Profile
        BlocProvider(create: (context) => EditProfileCubit()),

        // User Matching
        BlocProvider(create: (context) => MatchCubit()),

        // Language Management
        BlocProvider(
          create: (context) {

            final cubit = LanguageCubit();

            // Load saved language
            cubit.loadSavedLanguage();

            return cubit;

          },
        ),

        // Premium Membership Logic
        BlocProvider(create: (context) => PremiumBloc()),

      ],

      child: BlocBuilder<ThemeBloc, ThemeState>(

        builder: (context, theme) {

          return BlocBuilder<LanguageCubit, LanguageState>(

            buildWhen: (previous, current) => previous != current,

            builder: (context, languageState) {

              return MultiProvider(

                providers: [

                  // Onboarding Provider
                  ChangeNotifierProvider(create: (_) => OnBordingProvider()),

                  // Profile Details Provider
                  ChangeNotifierProvider(create: (_) => DetailProvider()),

                  // Home Screen Provider
                  ChangeNotifierProvider(create: (_) => HomeProvider()),

                  // Profile Provider
                  ChangeNotifierProvider(create: (_) => ProfileProvider()),

                  // Edit Profile Provider
                  ChangeNotifierProvider(create: (_) => EditProfileProvider()),

                  // Match Provider
                  ChangeNotifierProvider(create: (_) => MatchProvider()),

                  // Like Match Provider
                  ChangeNotifierProvider(create: (_) => LikeMatchProvider()),

                  // Firebase Authentication
                  ChangeNotifierProvider(create: (_) => FirebaseAuthService()),

                  // Chat Provider
                  ChangeNotifierProvider(create: (_) => ChattingProvider()),

                  // Video Call Provider
                  ChangeNotifierProvider(create: (_) => VcProvider()),

                  // Audio Call Provider
                  ChangeNotifierProvider(create: (_) => AudioCallProvider()),

                  // Premium Provider
                  ChangeNotifierProvider(create: (_) => PremiumProvider()),

                  // Wallet Provider
                  ChangeNotifierProvider(create: (_) => WalleteProvider()),

                  // Coin Purchase Provider
                  ChangeNotifierProvider(create: (_) => ByCoinProvider()),

                  // Firebase Chat Service
                  ChangeNotifierProvider(create: (_) => ChatServices()),

                ],

                child: MaterialApp(

                  // Wrap entire app inside SafeArea
                  builder: (context, child) {
                    return SafeArea(
                      top: false,
                      child: child!,
                    );
                  },

                  // Remove Debug Banner
                  debugShowCheckedModeBanner: false,

                  // First Screen
                  initialRoute: SplashScreen.splashScreenRoute,

                  // Theme
                  theme: theme.themeData,

                  // Global Navigation
                  navigatorKey: navigatorKey,

                  // Named Routes
                  onGenerateRoute: Routes.onGenerateRoute,

                  // Supported Languages
                  supportedLocales:
                      AppLocalizationSetup.supportedLanguage,

                  // Localization Delegates
                  localizationsDelegates:
                      AppLocalizationSetup.localizationsDelegates,

                  // Language Resolution
                  localeResolutionCallback:
                      AppLocalizationSetup.localeResolutionCallback,

                  // Current App Language
                  locale: languageState.locale,

                ),

              );

            },

          );

        },

      ),

    );

  }

}

// ==========================
// Background Notification
// ==========================

// Called when a notification is received while the app is
// in background or terminated.
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {

  // Handle background notification here

}