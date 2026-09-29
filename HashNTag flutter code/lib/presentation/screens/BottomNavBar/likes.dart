import 'package:dating/core/ui.dart';

import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:flutter/material.dart';
import '../../../language/localization/app_localization.dart';
import '../../widgets/fillButton.dart';

class LikesScreen extends StatefulWidget {
  static const likesScreenRoute = "/likeScreen";
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  static const Color _bg = Color(0xFF08050D);
  static const Color _surface = Color(0xFF171020);
  static const Color _surface2 = Color(0xFF21132D);
  static const Color _pink = Color(0xFFFF4FA3);
  static const Color _purple = Color(0xFF9B5CFF);
  static const Color _text = Color(0xFFF9F3FB);
  static const Color _muted = Color(0xFFD1C4D8);

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)?.translate(
          "Your admirers haven't noticed you yet",
        ) ??
        "Your admirers haven't noticed you yet";

    final description = AppLocalizations.of(context)?.translate(
          "Find here people who are intrested in you react on their profile for Crusher and to disccus in the maintime, put all the chances on your side with a great profile!",
        ) ??
        "Find here people who are intrested in you react on their profile for Crusher and to disccus in the maintime, put all the chances on your side with a great profile!";

    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: _bg,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: _pink,
          secondary: _purple,
          surface: _surface,
          onSurface: _text,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
          headlineMedium: const TextStyle(
            color: _text,
            fontSize: 27,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
          ),
          bodyMedium: const TextStyle(
            color: _muted,
            fontSize: 14,
            height: 1.55,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: _bg,
        body: Stack(
          children: [
            Positioned(
              top: -120,
              right: -90,
              child: IgnorePointer(
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _pink.withOpacity(0.20),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -130,
              left: -110,
              child: IgnorePointer(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _purple.withOpacity(0.18),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // Premium likes illustration.
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _pink.withOpacity(0.24),
                            _purple.withOpacity(0.22),
                          ],
                        ),
                        border: Border.all(
                          color: _pink.withOpacity(0.35),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _pink.withOpacity(0.16),
                            blurRadius: 35,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 22,
                            right: 23,
                            child: Icon(
                              Icons.favorite_rounded,
                              color: _purple.withOpacity(0.55),
                              size: 29,
                            ),
                          ),
                          Positioned(
                            bottom: 22,
                            left: 22,
                            child: Icon(
                              Icons.favorite_rounded,
                              color: _pink.withOpacity(0.45),
                              size: 22,
                            ),
                          ),
                          Container(
                            width: 88,
                            height: 88,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [_pink, _purple],
                              ),
                            ),
                            child: const Icon(
                              Icons.favorite_rounded,
                              color: Colors.white,
                              size: 47,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: _pink.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: _pink.withOpacity(0.25),
                        ),
                      ),
                      child: const Text(
                        "YOUR LIKES",
                        style: TextStyle(
                          color: Color(0xFFFF83BB),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 13),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Improve profile button.
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [_surface2, _surface],
                          ),
                          border: Border.all(
                            color: const Color(0xFF4A3556),
                          ),
                        ),
                        child: MainButton(
                          title: AppLocalizations.of(context)?.translate(
                                "Improve my profile",
                              ) ??
                              "Improve my profile",
                        ),
                      ),
                    ),

                    const SizedBox(height: 13),

                    // Boost button.
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [_pink, _purple],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _pink.withOpacity(0.22),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: FillButton(
                          bgColor: Colors.transparent,
                          title: AppLocalizations.of(context)?.translate(
                                "Boost your profile",
                              ) ??
                              "Boost your profile",
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
