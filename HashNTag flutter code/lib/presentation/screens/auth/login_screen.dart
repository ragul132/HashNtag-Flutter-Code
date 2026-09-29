import 'package:dating/Logic/cubits/onBording_cubit/onbording_cubit.dart';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_state.dart';
import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/splash_bording/creat_steps.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../../Logic/cubits/auth_cubit/auth_cubit.dart';
import '../../../Logic/cubits/auth_cubit/auth_state.dart';
import '../../../core/ui.dart';
import '../../../language/localization/app_localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String loginRoute = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late OnBordingProvider onBordingProvider;
  late OnbordingCubit onbordingCubit;

  int? otpvarable;

  @override
  void initState() {
    super.initState();

    // ORIGINAL LOGIC - unchanged
    BlocProvider.of<OnbordingCubit>(context).smstypeapi(context);

    onBordingProvider =
        Provider.of<OnBordingProvider>(context, listen: false);

    onBordingProvider.mobileNumber.text = '';
  }

  @override
  Widget build(BuildContext context) {
    onBordingProvider = Provider.of<OnBordingProvider>(context);
    onbordingCubit = Provider.of<OnbordingCubit>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF09050F),
      body: Stack(
        children: [
          // ============================================================
          // BACKGROUND
          // ============================================================
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF08050D),
                  Color(0xFF12071E),
                  Color(0xFF240A38),
                  Color(0xFF09050F),
                ],
              ),
            ),
          ),

          // TOP PURPLE GLOW
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF9B35FF).withOpacity(0.14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9B35FF).withOpacity(0.18),
                    blurRadius: 120,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          // BOTTOM PINK GLOW
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF2D8D).withOpacity(0.10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF2D8D).withOpacity(0.14),
                    blurRadius: 120,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==================================================
                    // BACK BUTTON
                    // ==================================================
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.10),
                            ),
                          ),
                          child: const BackButtons(),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.045),

                    // ==================================================
                    // APP NAME
                    // ==================================================
                    Center(
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFFF4DA6),
                                  Color(0xFFB85CFF),
                                ],
                              ).createShader(bounds);
                            },
                            child: const Text(
                              "FRIENDLYTHAI",
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Dating",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.72),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    // ==================================================
                    // LOGIN CARD
                    // ==================================================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 25),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.055),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.09),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.28),
                            blurRadius: 35,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ==================================================
                          // TITLE
                          // ==================================================
                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 29,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 7),

                          Text(
                            AppLocalizations.of(context)?.translate(
                                  "Welcome back! Please enter your details.",
                                ) ??
                                "Welcome back! Please enter your details.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.55),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // ==================================================
                          // EMAIL / MOBILE
                          // ==================================================
                          _darkTextField(
                            controller: onBordingProvider.emailLogin,
                            hintText: AppLocalizations.of(context)
                                    ?.translate("Email or MobileNumber") ??
                                "Email or MobileNumber",
                            icon: Icons.email_outlined,
                          ),

                          const SizedBox(height: 16),

                          // ==================================================
                          // PASSWORD
                          // ==================================================
                          _darkTextField(
                            controller: onBordingProvider.passwordLogin,
                            hintText: AppLocalizations.of(context)
                                    ?.translate("Password") ??
                                "Password",
                            icon: Icons.lock_outline_rounded,
                            obscureText: onBordingProvider.loginpassObs,
                            suffixIcon: onBordingProvider.loginpassObs
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onSuffixTap: () {
                              // ORIGINAL LOGIC - unchanged
                              onBordingProvider.updatebloginPass();
                            },
                          ),

                          const SizedBox(height: 15),

                          // ==================================================
                          // REMEMBER ME + FORGOT PASSWORD
                          //
                          // Remember Me is UI only because original file
                          // has no remember-me functionality.
                          // ==================================================
                          Row(
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Checkbox(
                                  value: false,
                                  onChanged: null,
                                  side: BorderSide(
                                    color: Colors.white.withOpacity(0.35),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.58),
                                  fontSize: 12.5,
                                ),
                              ),
                              const Spacer(),

                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)
                                              ?.translate(
                                            "Forgot password?",
                                          ) ??
                                          "Forgot password?",
                                      style: const TextStyle(
                                        color: Color(0xFFFF65AD),
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _showForgotPasswordSheet(context);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // ==================================================
                          // SIGN IN BUTTON
                          // ==================================================
                          _gradientButton(
                            title: AppLocalizations.of(context)
                                    ?.translate("Sign In") ??
                                "Sign In",
                            onTap: () {
                              // ORIGINAL LOGIN LOGIC - UNCHANGED
                              if (onBordingProvider.emailLogin.text.isEmpty ||
                                  onBordingProvider
                                      .passwordLogin.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "Please Enter All Input",
                                );
                              } else {
                                BlocProvider.of<OnbordingCubit>(context)
                                    .loginWithEmailPass(
                                  context: context,
                                  mobile:
                                      onBordingProvider.emailLogin.text,
                                  password:
                                      onBordingProvider.passwordLogin.text,
                                  ccode: "+91",
                                );
                              }
                            },
                          ),

                          const SizedBox(height: 27),

                          // ==================================================
                          // BOTTOM TEXT
                          // ==================================================

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          // ONBORDING BLOC LOADING / ERROR / NAVIGATION
          // ORIGINAL LOGIC
          // ==============================================================
          BlocConsumer<OnbordingCubit, OnbordingState>(
            listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }

              if (state is CompletSteps) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => BottomBar(),
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return Container(
                  color: Colors.black.withOpacity(0.35),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFF4DA6),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),

          // ==============================================================
          // AUTH BLOC
          // ORIGINAL LOGIC
          // ==============================================================
          BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
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
                  color: Colors.black.withOpacity(0.35),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFF4DA6),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // DARK TEXT FIELD
  // =========================================================================
  Widget _darkTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
  }) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.055),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.white.withOpacity(0.09),
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        cursorColor: const Color(0xFFFF4DA6),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.42),
            size: 21,
          ),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(
                    suffixIcon,
                    color: Colors.white.withOpacity(0.40),
                    size: 20,
                  ),
                ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.36),
            fontSize: 13.5,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // GRADIENT BUTTON
  // =========================================================================
  Widget _gradientButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFF3D96),
              Color(0xFFB64DFF),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF3D96).withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // FORGOT PASSWORD
  //
  // This contains the same OTP/API flow from the original file.
  // Both "Forgot password?" and "Reset it" used the same flow originally.
  // =========================================================================
  void _showForgotPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0xFF120A1B),
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF120A1B),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOP HANDLE
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    AppLocalizations.of(context)?.translate("Enter Number") ??
                        "Enter Number",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    "Enter your registered mobile number",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.50),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ========================================================
                  // PHONE FIELD
                  // ========================================================
                  IntlPhoneField(
                    initialCountryCode: "IN",
                    keyboardType: TextInputType.number,
                    cursorColor: const Color(0xFFFF4DA6),
                    showCountryFlag: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    disableLengthCheck: true,
                    controller: onBordingProvider.mobileNumber,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    dropdownIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white70,
                    ),
                    dropdownTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    onCountryChanged: (value) {
                      // ORIGINAL LOGIC
                      onBordingProvider.ccode =
                          onBordingProvider.updateVeriable(
                        value.dialCode,
                      );
                    },
                    onChanged: (value) {
                      // ORIGINAL LOGIC
                      onBordingProvider.updateNameFiled(
                        controller: onBordingProvider.mobileNumber,
                        value: value.number,
                      );
                    },
                    decoration: InputDecoration(
                      helperText: null,
                      hintText: AppLocalizations.of(context)?.translate(
                            "Mobile Number",
                          ) ??
                          "Mobile Number",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.35),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.055),
                      counterStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFFF4DA6),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.10),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.10),
                        ),
                      ),
                    ),
                    invalidNumberMessage: AppLocalizations.of(context)
                            ?.translate(
                          "Please enter your mobile number",
                        ) ??
                        "Please enter your mobile number",
                  ),

                  const SizedBox(height: 14),

                  // ========================================================
                  // CONTINUE
                  // ========================================================
                  _gradientButton(
                    title: AppLocalizations.of(context)?.translate(
                          "Continue",
                        ) ??
                        "Continue",
                    onTap: () {
                      // ======================================================
                      // ORIGINAL OTP LOGIC
                      // ======================================================
                      if (onbordingCubit.smaTypeApiModel?.otpAuth == "Yes") {
                        print("otp yes condition");

                        // ----------------------------------------------------
                        // MSG91
                        // ----------------------------------------------------
                        if (onbordingCubit.smaTypeApiModel?.smsType ==
                            "Msg91") {
                          if (onBordingProvider.mobileNumber.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please Enter Your Mobile Number",
                            );
                          } else {
                            onbordingCubit
                                .msgotpapi(
                              mobile:
                                  "+${onBordingProvider.ccode + onBordingProvider.mobileNumber.text}",
                              context: context,
                            )
                                .then((value) {
                              _showMsg91OtpSheet(context);
                            });
                          }
                        }

                        // ----------------------------------------------------
                        // TWILIO
                        // ----------------------------------------------------
                        else if (onbordingCubit
                                .smaTypeApiModel?.smsType ==
                            "Twilio") {
                          print("******* Twilio *******");

                          BlocProvider.of<OnbordingCubit>(context)
                              .mobileCheckApi(
                            number: onBordingProvider.mobileNumber.text,
                            ccode: onBordingProvider.ccode,
                          )
                              .then((value) {
                            if (value == "true") {
                              onbordingCubit
                                  .twilyootp(
                                mobile:
                                    "+${onBordingProvider.ccode + onBordingProvider.mobileNumber.text}",
                                context: context,
                              )
                                  .then((value) {
                                _showTwilioOtpSheet(context);
                              });
                            }
                          });
                        }

                        // ----------------------------------------------------
                        // NO SERVICE
                        // ----------------------------------------------------
                        else {
                          Fluttertoast.showToast(
                            msg: "No Service",
                          );
                        }
                      } else {
                        // ORIGINAL LOGIC
                        print("otp No condition");

                        onBordingProvider.newPassWord(
                          context,
                          onBordingProvider.mobileNumber.text,
                          onBordingProvider.ccode,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================================================================
  // MSG91 OTP SHEET
  // =========================================================================
  void _showMsg91OtpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (otpContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(otpContext).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF120A1B),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    "Awesome!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 7),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)?.translate(
                                "We have sent the OTP to",
                              ) ??
                              "We have sent the OTP to",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text:
                              " +${onBordingProvider.ccode} ${onBordingProvider.mobileNumber.text}",
                          style: const TextStyle(
                            color: Color(0xFFFF65AD),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ========================================================
                  // OTP
                  // ========================================================
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 45,
                    keyboardType: TextInputType.number,
                    outlineBorderRadius: 12,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.white.withOpacity(0.12),
                      errorBorderColor: Colors.white.withOpacity(0.12),
                      focusBorderColor: const Color(0xFFFF4DA6),
                      enabledBorderColor: Colors.white.withOpacity(0.12),
                      disabledBorderColor: Colors.white.withOpacity(0.12),
                      backgroundColor: Colors.white.withOpacity(0.05),
                    ),
                    onChanged: (value) {
                      // ORIGINAL LOGIC
                      onBordingProvider.otp = value;
                      otpvarable = int.parse(onBordingProvider.otp);
                      print("77777:--- $otpvarable");

                      setState(() {});
                    },
                  ),

                  const SizedBox(height: 25),

                  _gradientButton(
                    title: AppLocalizations.of(context)?.translate(
                          "Continue",
                        ) ??
                        "Continue",
                    onTap: () async {
                      // ORIGINAL LOGIC
                      if (onbordingCubit.msgApiModel.otp == otpvarable) {
                        Navigator.pop(otpContext);

                        onBordingProvider.newPassWord(
                          context,
                          onBordingProvider.mobileNumber.text,
                          onBordingProvider.ccode,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "opt not valide",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================================================================
  // TWILIO OTP SHEET
  // =========================================================================
  void _showTwilioOtpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (otpContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(otpContext).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF120A1B),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    "Awesome!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 7),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)?.translate(
                                "We have sent the OTP to",
                              ) ??
                              "We have sent the OTP to",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text:
                              " +${onBordingProvider.ccode} ${onBordingProvider.mobileNumber.text}",
                          style: const TextStyle(
                            color: Color(0xFFFF65AD),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ========================================================
                  // OTP
                  // ========================================================
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 45,
                    keyboardType: TextInputType.number,
                    outlineBorderRadius: 12,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.white.withOpacity(0.12),
                      errorBorderColor: Colors.white.withOpacity(0.12),
                      focusBorderColor: const Color(0xFFFF4DA6),
                      enabledBorderColor: Colors.white.withOpacity(0.12),
                      disabledBorderColor: Colors.white.withOpacity(0.12),
                      backgroundColor: Colors.white.withOpacity(0.05),
                    ),
                    onChanged: (value) {
                      // ORIGINAL LOGIC
                      onBordingProvider.otp = value;
                      otpvarable = int.parse(onBordingProvider.otp);
                      print("77777:--- $otpvarable");

                      setState(() {});
                    },
                  ),

                  const SizedBox(height: 25),

                  _gradientButton(
                    title: AppLocalizations.of(context)?.translate(
                          "Continue",
                        ) ??
                        "Continue",
                    onTap: () async {
                      // ORIGINAL LOGIC
                      if (onbordingCubit.twilioApiModel.otp == otpvarable) {
                        Navigator.pop(otpContext);

                        onBordingProvider.newPassWord(
                          context,
                          onBordingProvider.mobileNumber.text,
                          onBordingProvider.ccode,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "opt not valide",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
