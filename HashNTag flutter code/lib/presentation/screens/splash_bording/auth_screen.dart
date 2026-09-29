import 'dart:async';

import 'package:camera/camera.dart';
import 'package:dating/Logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:dating/Logic/cubits/auth_cubit/auth_state.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/splash_bording/creat_steps.dart';
import 'package:dating/presentation/screens/auth/login_screen.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Logic/cubits/onBording_cubit/onbording_cubit.dart';
import '../../../language/localization/app_localization.dart';
import '../other/profileScreen/profile_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String authScreenRoute = "/authScreen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with TickerProviderStateMixin {
  late OnBordingProvider onBordingProvider;
  late OnbordingCubit onbordingCubit;

  @override
  void initState() {
    _requestCameraPermission();

    setOnbordingFalse();
    BlocProvider.of<OnbordingCubit>(context).smstypeapi(context);

    super.initState();
  }

  Future<void> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      imagecontroller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      initializeControllerFuture = imagecontroller.initialize();
    } else {
      print('Camera permission is not granted');
    }
  }

  setOnbordingFalse() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("Onbording", false);
  }

  @override
  Widget build(BuildContext context) {
    onBordingProvider = Provider.of<OnBordingProvider>(context);
    onbordingCubit = Provider.of<OnbordingCubit>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF09060F),
      body: Stack(
        children: [
          // Existing image slider - logic unchanged.
          const ImageSlider(
            imageUrls: [
              'assets/Image/img1.jpg',
              'assets/Image/img2.jpg',
              'assets/Image/img3.jpg',
            ],
          ),

          // Dark/purple overlay to match the new login theme.
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.34, 0.70, 1.0],
                    colors: [
                      Colors.black.withOpacity(0.18),
                      const Color(0xFF12091F).withOpacity(0.28),
                      const Color(0xFF4B147D).withOpacity(0.68),
                      const Color(0xFF9B32E8).withOpacity(0.96),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Extra soft bottom glow.
          Positioned(
            left: -size.width * 0.25,
            right: -size.width * 0.25,
            bottom: -size.height * 0.18,
            child: IgnorePointer(
              child: Container(
                height: size.height * 0.42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width),
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFE83EBD).withOpacity(0.32),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 22),

                // Logo area.
                Container(
                  width: 78,
                  height: 78,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.94),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    "assets/Image/appLogo.svg",
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: Column(
                    children: [
                      // Heading.
                      Text(
                        AppLocalizations.of(context)?.translate(
                              "Let's dive in into your account!",
                            ) ??
                            "Let's dive in into your account!",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),

                      const SizedBox(height: 9),

                      const Text(
                        "Find your connection. Start your journey.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Existing registration navigation - unchanged.
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF4FA3),
                                Color(0xFF9B42FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFB13CFF).withOpacity(0.32),
                                blurRadius: 20,
                                offset: const Offset(0, 9),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () {
                                onBordingProvider.updatestepsCount(0);
                                Navigator.pushNamed(
                                  context,
                                  CreatSteps.creatStepsRoute,
                                );
                              },
                              child: const Center(
                                child: Text(
                                  "Continue with Email/Mobile Number",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Existing Login navigation - unchanged.
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)?.translate(
                                    "I have an account? ",
                                  ) ??
                                  "I have an account? ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                    LoginScreen.loginRoute,
                                  );
                                },
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13.5,
                              ),
                            ),
                            TextSpan(
                              text: "Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                    LoginScreen.loginRoute,
                                  );
                                },
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Existing Auth Bloc logic - unchanged.
          BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }

              if (state is AuthLoggedInState) {
                Navigator.pushNamed(
                  context,
                  CreatSteps.creatStepsRoute,
                );
                onBordingProvider.setDataInFildes(
                  state.firebaseuser,
                );
              }

              if (state is AuthUserHomeState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  BottomBar.bottomBarRoute,
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.25),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ImageSlider({
    super.key,
    required this.imageUrls,
  });

  @override
  ImageSliderState createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Gen-Z style ambient animation.
    // No background photos and no image slideshow.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_controller.value);
        final size = MediaQuery.of(context).size;

        return Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF09060F),
                Color(0xFF24103D),
                Color(0xFF4C155F),
                Color(0xFF100817),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Large moving pink glow.
              Positioned(
                left: -size.width * 0.28 + (t * size.width * 0.16),
                top: size.height * 0.08,
                child: _GlowOrb(
                  size: size.width * 0.82,
                  color: const Color(0xFFFF3FA4),
                ),
              ),

              // Large moving purple glow.
              Positioned(
                right: -size.width * 0.30 - (t * size.width * 0.14),
                top: size.height * 0.28,
                child: _GlowOrb(
                  size: size.width * 0.88,
                  color: const Color(0xFF8B3DFF),
                ),
              ),

              // Bottom violet glow.
              Positioned(
                left: size.width * 0.08,
                bottom: -size.height * 0.18 + (t * 25),
                child: _GlowOrb(
                  size: size.width * 0.78,
                  color: const Color(0xFFE84DFF),
                ),
              ),

              // Subtle floating hearts.
              const _FloatingHeart(
                leftFactor: 0.12,
                topFactor: 0.22,
                size: 23,
                delay: 0.0,
              ),
              const _FloatingHeart(
                leftFactor: 0.78,
                topFactor: 0.17,
                size: 17,
                delay: 0.35,
              ),
              const _FloatingHeart(
                leftFactor: 0.18,
                topFactor: 0.62,
                size: 14,
                delay: 0.65,
              ),
              const _FloatingHeart(
                leftFactor: 0.84,
                topFactor: 0.70,
                size: 24,
                delay: 0.2,
              ),
              const _FloatingHeart(
                leftFactor: 0.55,
                topFactor: 0.10,
                size: 12,
                delay: 0.8,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.34),
              color.withOpacity(0.13),
              Colors.transparent,
            ],
            stops: const [0.0, 0.38, 1.0],
          ),
        ),
      ),
    );
  }
}

class _FloatingHeart extends StatefulWidget {
  final double leftFactor;
  final double topFactor;
  final double size;
  final double delay;

  const _FloatingHeart({
    required this.leftFactor,
    required this.topFactor,
    required this.size,
    required this.delay,
  });

  @override
  State<_FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<_FloatingHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 3200 + (widget.delay * 1000).round(),
      ),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * widget.leftFactor,
      top: MediaQuery.of(context).size.height * widget.topFactor,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value =
              Curves.easeInOut.transform(_controller.value);

          return Transform.translate(
            offset: Offset(
              0,
              -10 * value,
            ),
            child: Transform.rotate(
              angle: -0.08 + (0.16 * value),
              child: Opacity(
                opacity: 0.28 + (0.22 * value),
                child: Icon(
                  Icons.favorite_rounded,
                  size: widget.size,
                  color: const Color(0xFFFF70C3),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
