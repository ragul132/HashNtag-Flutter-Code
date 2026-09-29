import 'dart:io';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_cubit.dart';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_state.dart';
import 'package:dating/core/config.dart';
import 'package:dating/data/models/languagemodel.dart';
import 'package:dating/data/models/relationGoalModel.dart';
import 'package:dating/data/models/religionmodel.dart';
import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:dating/presentation/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import '../../../core/ui.dart';
import '../../../data/models/getinterest_model.dart';
import '../../../language/localization/app_localization.dart';
import '../../widgets/main_button.dart';

class CreatSteps extends StatefulWidget {
  static const String creatStepsRoute = "/creatSteps";
  const CreatSteps({super.key});

  @override
  State<CreatSteps> createState() => _CreatStepsState();
}

class _CreatStepsState extends State<CreatSteps> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<OnbordingCubit>(context).smstypeapi(context);


    BlocProvider.of<OnbordingCubit>(context).relationGoalListApi().then((value) {
      onBordingProvider.setRelationGoalModel(value);
    });

    BlocProvider.of<OnbordingCubit>(context).getInterestApi().then((value) {
      onBordingProvider.setInterestModel(value);
    });

    BlocProvider.of<OnbordingCubit>(context).languagelistApi().then((value) {
      onBordingProvider.setlanguageModel(value);
    });

    BlocProvider.of<OnbordingCubit>(context).religionApi().then((value) {
      onBordingProvider.setreligionModel(value);
    });

  }

  @override
  void dispose() {
    super.dispose();
    onBordingProvider.desposee();
  }

  late OnBordingProvider onBordingProvider;
  late OnbordingCubit onbordingCubit;


  int? otpvarable;

  @override
  Widget build(BuildContext context) {
    onBordingProvider = Provider.of<OnBordingProvider>(context);
    onbordingCubit = Provider.of<OnbordingCubit>(context);
    return PopScope(
      canPop: onBordingProvider.stepsCount == 0 ? true : false,
      onPopInvoked: (b) async {
        if (onBordingProvider.stepsCount == 0) {
          // await GoogleSignIn().signOut();
          // await FacebookAuth.instance.logOut();
        } else {
          onBordingProvider.updatestepsCount(onBordingProvider.stepsCount - 1);
        }
      },
      child: Theme(
        data: Theme.of(context).copyWith(
          scaffoldBackgroundColor: const Color(0xFF08050D),
          canvasColor: const Color(0xFF08050D),
          cardColor: const Color(0xFF171020),
          dividerColor: const Color(0xFF382842),
          dividerTheme: const DividerThemeData(
            color: Color(0xFF382842),
            thickness: 1,
          ),
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: const Color(0xFFFF4FA3),
            secondary: const Color(0xFF9B5CFF),
            surface: const Color(0xFF171020),
            onSurface: Colors.white,
            onBackground: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Color(0xFF120B1C),
            surfaceTintColor: Colors.transparent,
            modalBackgroundColor: Color(0xFF120B1C),
          ),
          dialogTheme: const DialogThemeData(
            backgroundColor: Color(0xFF120B1C),
            surfaceTintColor: Colors.transparent,
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
            displayLarge: const TextStyle(color: Colors.white),
            displayMedium: const TextStyle(color: Colors.white),
            displaySmall: const TextStyle(color: Colors.white),
            headlineLarge: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
            headlineMedium: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800,
              height: 1.18,
            ),
            headlineSmall: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
            titleLarge: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            titleMedium: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.45,
            ),
            bodyMedium: const TextStyle(
              color: Color(0xFFC9BDCE),
              fontSize: 14,
              height: 1.45,
            ),
            bodySmall: const TextStyle(
              color: Color(0xFFA99CB1),
              fontSize: 12,
              height: 1.35,
            ),
            labelLarge: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF171020),
            hintStyle: const TextStyle(
              color: Color(0xFF81758D),
              fontSize: 14,
            ),
            labelStyle: const TextStyle(color: Color(0xFFC8BFD0)),
            prefixIconColor: const Color(0xFFBFAEC9),
            suffixIconColor: const Color(0xFFFF69AF),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF34243F)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFFFF4FA3), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFFFF6B81)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFFFF6B81), width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF34243F)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          ),
        ),
        child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {

              if (onBordingProvider.name.text.isNotEmpty && onBordingProvider.email.text.isNotEmpty && onBordingProvider.password.text.isNotEmpty && onBordingProvider.stepsCount == 0) {
                onBordingProvider.updatestepsCount(1);
              } else if (onBordingProvider.mobileNumber.text.isNotEmpty && onBordingProvider.stepsCount == 1) {

                if(onbordingCubit.smaTypeApiModel?.otpAuth == "Yes" ){


                   if (onbordingCubit.smaTypeApiModel?.smsType == "Msg91") {
                    print("******* Msg91 *******");

                    BlocProvider.of<OnbordingCubit>(context).mobileCheckApi(number: onBordingProvider.mobileNumber.text, ccode: onBordingProvider.ccode).then((value) {
                      if (value == "true") {


                        onbordingCubit.msgotpapi(mobile: "+${onBordingProvider.ccode + onBordingProvider.mobileNumber.text}", context: context).then((value) {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: false,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Awesome", style: Theme.of(context).textTheme.headlineSmall),
                                          const SizedBox(height: 5),
                                          RichText(text: TextSpan(children: [
                                            TextSpan(text: AppLocalizations.of(context)?.translate("We have sent the OTP to") ?? "We have sent the OTP to",style: Theme.of(context).textTheme.bodyMedium),
                                            TextSpan(text: " +${onBordingProvider.ccode} ${onBordingProvider.mobileNumber.text}",style: Theme.of(context).textTheme.bodyMedium),
                                          ])),
                                          const SizedBox(height: 10),

                                          OTPTextField(
                                            length: 6,
                                            width: MediaQuery.of(context).size.width,
                                            fieldWidth: 45,
                                            keyboardType: TextInputType.number,
                                            outlineBorderRadius: 8,
                                            style: Theme.of(context).textTheme.headlineSmall!,
                                            textFieldAlignment: MainAxisAlignment.spaceAround,
                                            fieldStyle: FieldStyle.box,
                                            otpFieldStyle: OtpFieldStyle(borderColor: Theme.of(context).dividerTheme.color!,errorBorderColor: Theme.of(context).dividerTheme.color!,focusBorderColor: AppColors.appColor,enabledBorderColor: Theme.of(context).dividerTheme.color!,disabledBorderColor: Theme.of(context).dividerTheme.color!,backgroundColor: Theme.of(context).cardColor),
                                            onChanged: (value) {
                                              onBordingProvider.otp = value;
                                              otpvarable = int.parse(onBordingProvider.otp);
                                              print("77777:--- ${otpvarable}");
                                              setState(() {

                                              });
                                            },
                                          ),

                                          const SizedBox(height: 20),
                                          MainButton(
                                            title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",
                                            onTap: () async {


                                              if (onbordingCubit.msgApiModel.otp == otpvarable) {

                                                onBordingProvider.updatestepsCount(2);
                                                Navigator.pop(context);

                                              }
                                              else {
                                                Fluttertoast.showToast(msg: "opt not valide");
                                              }

                                            },

                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },);

                      }
                    });

                  }
                  else if (onbordingCubit.smaTypeApiModel?.smsType == "Twilio") {
                    print("******* Twilio *******:---   +${onBordingProvider.ccode + onBordingProvider.mobileNumber.text}");

                    BlocProvider.of<OnbordingCubit>(context).mobileCheckApi(number: onBordingProvider.mobileNumber.text, ccode: onBordingProvider.ccode).then((value) {
                      if (value == "true") {

                        onbordingCubit.twilyootp(mobile: "+${onBordingProvider.ccode + onBordingProvider.mobileNumber.text}", context: context).then((value) {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: false,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Awesome", style: Theme.of(context).textTheme.headlineSmall),
                                          const SizedBox(height: 5),
                                          RichText(text: TextSpan(children: [
                                            TextSpan(text: AppLocalizations.of(context)?.translate("We have sent the OTP to") ?? "We have sent the OTP to",style: Theme.of(context).textTheme.bodyMedium),
                                            TextSpan(text: " +${onBordingProvider.ccode} ${onBordingProvider.mobileNumber.text}",style: Theme.of(context).textTheme.bodyMedium),
                                          ])),
                                          const SizedBox(height: 10),

                                          OTPTextField(
                                            length: 6,
                                            width: MediaQuery.of(context).size.width,
                                            fieldWidth: 45,
                                            keyboardType: TextInputType.number,
                                            outlineBorderRadius: 8,
                                            style: Theme.of(context).textTheme.headlineSmall!,
                                            textFieldAlignment: MainAxisAlignment.spaceAround,
                                            fieldStyle: FieldStyle.box,
                                            otpFieldStyle: OtpFieldStyle(borderColor: Theme.of(context).dividerTheme.color!,errorBorderColor: Theme.of(context).dividerTheme.color!,focusBorderColor: AppColors.appColor,enabledBorderColor: Theme.of(context).dividerTheme.color!,disabledBorderColor: Theme.of(context).dividerTheme.color!,backgroundColor: Theme.of(context).cardColor),
                                            onChanged: (value) {
                                              onBordingProvider.otp = value;
                                              otpvarable = int.parse(onBordingProvider.otp);
                                              print("77777:--- ${otpvarable}");
                                              setState(() {

                                              });
                                            },
                                          ),

                                          const SizedBox(height: 20),
                                          MainButton(
                                            title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",
                                            onTap: () async {


                                              if (onbordingCubit.twilioApiModel.otp == otpvarable) {
                                                onBordingProvider.updatestepsCount(2);
                                                Navigator.pop(context);
                                              }
                                              else {
                                                Fluttertoast.showToast(msg: "opt not valide");
                                              }

                                            },

                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },);

                      }
                    });


                  }
                  else {
                    Fluttertoast.showToast(msg: "No Service");
                  }
                }
                else{
                  print("no otp");
                  BlocProvider.of<OnbordingCubit>(context).mobileCheckApi(number: onBordingProvider.mobileNumber.text, ccode: onBordingProvider.ccode).then((value) {
                    if (value == "true") {
                      onBordingProvider.updatestepsCount(2);
                    }
                  });
                }
              } else if (onBordingProvider.bdatePicker.toString() != "null" && onBordingProvider.stepsCount == 2) {
                onBordingProvider.updatestepsCount(3);
              } else if (onBordingProvider.select >= 0 && onBordingProvider.stepsCount == 3) {
                onBordingProvider.updatestepsCount(4);
              } else if (onBordingProvider.relationGoal >= 0 && onBordingProvider.stepsCount == 4) {
                onBordingProvider.updatestepsCount(5);
              } else if (onBordingProvider.kmCounter >= 10 && onBordingProvider.stepsCount == 5) {
                onBordingProvider.updatestepsCount(6);
              } else if (onBordingProvider.selectHobi.isNotEmpty && onBordingProvider.selectHobi.length <= 5 && onBordingProvider.stepsCount == 6) {
                onBordingProvider.updatestepsCount(7);
              } else if (onBordingProvider.selectedLanguage.isNotEmpty && onBordingProvider.stepsCount == 7) {
                onBordingProvider.updatestepsCount(8);
              } else if (onBordingProvider.selectReligion >= 0 && onBordingProvider.stepsCount == 8) {
                onBordingProvider.updatestepsCount(9);
              } else if (onBordingProvider.select1 >= 0 && onBordingProvider.stepsCount == 9) {
                onBordingProvider.updatestepsCount(10);
              } else if (onBordingProvider.stepsCount == 10 && onBordingProvider.images.length >= 3) {
                BlocProvider.of<OnbordingCubit>(context).registerUserApi(
                        name: onBordingProvider.name.text,
                        email: onBordingProvider.email.text,
                        mobile: onBordingProvider.mobileNumber.text,
                        ccode: "+${onBordingProvider.ccode}",
                        bday: onBordingProvider.bdatePicker.toString().split(" ").first,
                        searchPreference: onBordingProvider.maleFemaleBoth(onBordingProvider.select1),
                        rediusSearch: onBordingProvider.kmCounter.toStringAsFixed(2),
                        relationGoal: onBordingProvider.relationGoal.toString(),
                        profileBio: onBordingProvider.bio.text,
                        intrest: onBordingProvider.selectHobi.join(","),
                        language: onBordingProvider.selectedLanguage.join(","),
                        password: onBordingProvider.password.text,
                        refCode: onBordingProvider.referelCode.text,
                        gender: onBordingProvider.maleFemaleOther(onBordingProvider.select),
                        lat: onBordingProvider.lat.toString(),
                        long: onBordingProvider.long.toString(),
                        religon: onBordingProvider.selectReligion.toString(),
                        images: onBordingProvider.images,context: context)
                    .then((value) {

                      print("{{{{{{{{{{ value }}}}}}}}}}:- ${value.result}");

                      if(value.result == "true"){
                        onBordingProvider.name.text = "";
                        onBordingProvider.email.text = "";
                        onBordingProvider.mobileNumber.text = "";
                        onBordingProvider.ccode = "91";
                        onBordingProvider.bdatePicker = null;
                        onBordingProvider.select1 = -1;
                        onBordingProvider.kmCounter = 10;
                        onBordingProvider.relationGoal = -1;
                        onBordingProvider.bio.text = "";
                        onBordingProvider.selectHobi = [];
                        onBordingProvider.selectedLanguage = [];
                        onBordingProvider.password.text = "";
                        onBordingProvider.referelCode.text = "";
                        onBordingProvider.select = -1;
                        onBordingProvider.lat = 0.0;
                        onBordingProvider.long = 0.0;
                        onBordingProvider.selectReligion = -1;
                        onBordingProvider.images = [];
                        Fluttertoast.showToast(msg: value.responseMsg.toString());
                      }else{
                        Fluttertoast.showToast(msg: value.responseMsg.toString());
                      }


                });
              }
              else {
                if ((onBordingProvider.name.text.isEmpty || onBordingProvider.email.text.isEmpty || onBordingProvider.password.text.isEmpty) && onBordingProvider.stepsCount == 0) {
                  if (onBordingProvider.name.text.isEmpty) {
                    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter Name") ?? "Please Enter Name");
                  } else if (onBordingProvider.email.text.isEmpty) {
                    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter Email") ?? "Please Enter Email");
                  } else if (onBordingProvider.password.text.isEmpty) {
                    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter Password") ?? "Please Enter Password");
                  }
                } else if (onBordingProvider.mobileNumber.text.isEmpty &&
                    onBordingProvider.stepsCount == 1) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter MobileNumber") ?? "Please Enter MobileNumber");
                } else if (onBordingProvider.bdatePicker.toString() == "null" &&
                    onBordingProvider.stepsCount == 2) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter BirthDate") ?? "Please Enter BirthDate");
                } else if (onBordingProvider.select < 0 &&
                    onBordingProvider.stepsCount == 3) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Gender") ?? "Please Select Gender");
                } else if (onBordingProvider.relationGoal < 0 &&
                    onBordingProvider.stepsCount == 4) {
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)?.translate("Please Select Relationship Goals") ?? "Please Select Relationship Goals");
                } else if (onBordingProvider.kmCounter < 10 &&
                    onBordingProvider.stepsCount == 5) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Nearby") ?? "Please Select Nearby");
                } else if (onBordingProvider.selectHobi.length <= 5 &&
                    onBordingProvider.stepsCount == 6) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Hobies") ?? "Please Select Hobies");
                } else if (onBordingProvider.selectedLanguage.isNotEmpty &&
                    onBordingProvider.stepsCount == 7) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Language") ?? "Please Select Language");
                } else if (onBordingProvider.selectReligion < 0 &&
                    onBordingProvider.stepsCount == 8) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Religion") ?? "Please Select Religion");
                } else if (onBordingProvider.select1 < 0 &&
                    onBordingProvider.stepsCount == 9) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Gender") ?? "Please Select Gender");
                } else if (onBordingProvider.stepsCount == 10 &&
                    onBordingProvider.images.length < 3) {
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Minimum 3 Images") ?? "Please Select Minimum 3 Images");
                }
              }
            },
            backgroundColor: const Color(0xFFFF4FA3),
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 28),
          ),
        backgroundColor: const Color(0xFF08050D),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(92),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0D0915).withOpacity(0.97),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (onBordingProvider.stepsCount > 0)
                        GestureDetector(
                          onTap: () {
                            onBordingProvider.updatestepsCount(onBordingProvider.stepsCount - 1);
                          },
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFF33243F)),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                          ),
                        )
                      else
                        const SizedBox(width: 42),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'PROFILE SETUP',
                                  style: const TextStyle(
                                    color: Color(0xFFB9AFC2),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.6,
                                  ),
                                ),
                                Text(
                                  '${onBordingProvider.stepsCount + 1} / 11',
                                  style: const TextStyle(
                                    color: Color(0xFFFF79B8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 9),
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(
                                begin: 0,
                                end: (onBordingProvider.stepsCount + 1) / 11,
                              ),
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF21162B),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      FractionallySizedBox(
                                        widthFactor: value.clamp(0.0, 1.0),
                                        child: Container(
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFFFF4FA3), Color(0xFF9B5CFF)],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF08050D),
                Color(0xFF1B0B2B),
                Color(0xFF0B0711),
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -90,
                  right: -80,
                  child: IgnorePointer(
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFFF4FA3).withOpacity(0.22),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -110,
                  left: -100,
                  child: IgnorePointer(
                    child: Container(
                      width: 270,
                      height: 270,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF8F4DFF).withOpacity(0.18),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Builder(builder: (context) {
                switch (onBordingProvider.stepsCount) {
                  case 0:
                    return step1();
                  case 1:
                    return step2();
                  case 2:
                    return step3();
                  case 3:
                    return step4();
                  case 4:
                    return step5();
                  case 5:
                    return step6();
                  case 6:
                    return step7();
                  case 7:
                    return step8();
                  case 8:
                    return step9();
                  case 9:
                    return step10();
                  case 10:
                    return step11();
                  default:
                    return step1();
                }
              }),
              BlocConsumer<OnbordingCubit, OnbordingState>(
                  listener: (context, state) {
                if (state is CompletSteps) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, BottomBar.bottomBarRoute, (route) => false);
                }
                if (state is ErrorState) {
                  Fluttertoast.showToast(msg: state.error);
                }
              }, builder: (context, state) {
                if (state is LoadingState) {
                  return CircularProgressIndicator(color: AppColors.appColor);
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
        ),
        ),
      ),
    );
  }

  Widget step1() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            AppLocalizations.of(context)?.translate(
                  "Let’s create your profile ✨",
                ) ??
                "Let’s create your profile ✨",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)?.translate(
                  "Tell us a little about yourself. These details will appear on your profile.",
                ) ??
                "Tell us a little about yourself. These details will appear on your profile.",
            style: const TextStyle(
              color: Color(0xFFB5A8BE),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _premiumTextField(
            controller: onBordingProvider.name,
            hintText: AppLocalizations.of(context)?.translate("Frist Name") ??
                "First Name",
            icon: Icons.person_outline_rounded,
            suffixIconPath: onBordingProvider.name.text.isEmpty
                ? ""
                : "assets/icons/verify.svg",
            onChangee: (e) {
              onBordingProvider.updateNameFiled(
                controller: onBordingProvider.name,
                value: e,
              );
            },
          ),
          const SizedBox(height: 14),
          _premiumTextField(
            controller: onBordingProvider.email,
            hintText:
                AppLocalizations.of(context)?.translate("Email") ?? "Email",
            icon: Icons.mail_outline_rounded,
            readOnly: onBordingProvider.isEmailEdite,
            suffixIconPath: onBordingProvider.email.text.isEmpty
                ? ""
                : "assets/icons/verify.svg",
            onChangee: (e) {
              onBordingProvider.updateNameFiled(
                controller: onBordingProvider.email,
                value: e,
              );
            },
          ),
          const SizedBox(height: 14),
          _premiumTextField(
            controller: onBordingProvider.password,
            hintText: AppLocalizations.of(context)?.translate("Password") ??
                "Password",
            icon: Icons.lock_outline_rounded,
            obscureText: onBordingProvider.isLast,
            suffixIconPath: onBordingProvider.isLast
                ? "assets/icons/eye-slash.svg"
                : "assets/icons/eye.svg",
            surfixOntap: () {
              onBordingProvider.updateIsLast();
            },
            onChangee: (e) {
              onBordingProvider.updateNameFiled(
                controller: onBordingProvider.password,
                value: e,
              );
            },
          ),
          const SizedBox(height: 14),
          _premiumTextField(
            controller: onBordingProvider.referelCode,
            hintText: "Referral Code",
            icon: Icons.card_giftcard_rounded,
            onChangee: (e) {
              onBordingProvider.updateNameFiled(
                controller: onBordingProvider.referelCode,
                value: e,
              );
            },
          ),
          const SizedBox(height: 14),
          _premiumTextField(
            controller: onBordingProvider.bio,
            hintText:
                AppLocalizations.of(context)?.translate("Bio") ?? "Bio",
            icon: Icons.auto_awesome_outlined,
            maxline: 5,
            onChangee: (e) {
              onBordingProvider.updateNameFiled(
                controller: onBordingProvider.bio,
                value: e,
              );
            },
          ),
          const SizedBox(height: 18),
          _secureHint(),
        ],
      ),
    );
  }

  Widget _sectionEyebrow(String text) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 3,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF4FA3), Color(0xFF9B5CFF)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFFFF78B7),
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _premiumTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required Function(String) onChangee,
    bool obscureText = false,
    bool readOnly = false,
    String? suffixIconPath,
    VoidCallback? surfixOntap,
    int maxline = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF21142D).withOpacity(0.95),
            const Color(0xFF120C1A).withOpacity(0.98),
          ],
        ),
        border: Border.all(color: const Color(0xFF3A2847)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 16,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: maxline,
        onChanged: onChangee,
        cursorColor: const Color(0xFFFF4FA3),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: false,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF85798F),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFBFAFC8),
            size: 21,
          ),
          suffixIcon: suffixIconPath == null || suffixIconPath.isEmpty
              ? null
              : InkWell(
                  onTap: surfixOntap,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      suffixIconPath,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFF68AE),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
        ),
      ),
    );
  }

  Widget _secureHint() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161020).withOpacity(0.72),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF30213A)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.shield_outlined,
            color: Color(0xFFB57CFF),
            size: 19,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Your details are private and used only to create your profile.",
              style: TextStyle(
                color: Color(0xFFAFA2B9),
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget step2() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Your Thai identity 😎") ?? "Your Thai identity 😎",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.012),
          Text(
            AppLocalizations.of(context)?.translate("Add your phone number and your job to tell others what you do for a living.") ?? "Add your phone number and your job to tell others what you do for a living.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.02),
          IntlPhoneField(
            initialCountryCode: "IN",
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            showCountryFlag: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            disableLengthCheck: true,
            controller: onBordingProvider.mobileNumber,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            dropdownIcon: const Icon(
              Icons.arrow_drop_down,
            ),
            dropdownTextStyle: Theme.of(context).textTheme.bodyMedium,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                ,
            onCountryChanged: (value) {
              onBordingProvider.ccode = onBordingProvider.updateVeriable(value.dialCode);
              print("++++++${onBordingProvider.ccode}");
            },
            onChanged: (value) {
              onBordingProvider.updateNameFiled(
                  controller: onBordingProvider.mobileNumber,
                  value: value.number);
            },
            decoration: InputDecoration(
              helperText: null,
              hintText: AppLocalizations.of(context)?.translate("Mobile Number") ?? "Mobile Number",
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              focusedBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: AppColors.appColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).dividerTheme.color!,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            invalidNumberMessage: AppLocalizations.of(context)?.translate("Please enter your mobile number") ?? "Please enter your mobile number",
          ),
        ],
      ),
    );
  }

  Widget step3() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Let's celebrate you 🎂") ?? "Let's celebrate you 🎂",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.012),
          Text(
            AppLocalizations.of(context)?.translate("Tell us your birthdate. Your profile does not display your birthdate, only your age.") ?? "Tell us your birthdate. Your profile does not display your birthdate, only your age.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime(2000, 1, 1),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  onBordingProvider.updatebdate(newDateTime);
                                },
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                              "${onBordingProvider.bdatePicker}" != "null"
                                  ? onBordingProvider.bdatePicker
                                      .toString()
                                      .split(" ")
                                      .first
                                  : "YYYY - MM - DD",
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget step4() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Be true to yourself 🌟") ?? "Be true to yourself 🌟",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            AppLocalizations.of(context)?.translate("Choose the gender that best represents you. Authenticity is key to meaningful connections.") ?? "Choose the gender that best represents you. Authenticity is key to meaningful connections.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (c, i) {
                return const SizBoxH(size: 0.012);
              },
              shrinkWrap: true,
              itemCount: onBordingProvider.manWoman.length,
              itemBuilder: (c, i) {
                return InkWell(
                  onTap: () {
                    onBordingProvider.updateMaleFemale(i);
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: onBordingProvider.select == i
                                ? AppColors.appColor
                                : Theme.of(context).dividerTheme.color!)),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          onBordingProvider.manWoman[i],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onBordingProvider.select == i
                            ? SvgPicture.asset("assets/icons/verify.svg")
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget step5() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.translate("Your relationship goals 💘") ?? "Your relationship goals 💘",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizBoxH(size: 0.012),
            Text(
              AppLocalizations.of(context)?.translate("Choose the type of relationship you're seeking on Datify. Love, friendship, or something in between—it's your choice.") ?? "Choose the type of relationship you're seeking on Datify. Love, friendship, or something in between—it's your choice.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizBoxH(size: 0.018),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (c, i) {
                  return const SizBoxH(size: 0.012);
                },
                shrinkWrap: true,
                itemCount:
                    onBordingProvider.relationGoalData?.goallist!.length ?? 0,
                itemBuilder: (c, i) {
                  Goallist? data =
                      onBordingProvider.relationGoalData?.goallist?[i];
                  return InkWell(
                    onTap: () {
                      onBordingProvider
                          .updaterelationGoal(int.parse(data.id.toString()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              color: onBordingProvider.relationGoal ==
                                      int.parse(data!.id.toString())
                                  ? AppColors.appColor
                                  : Theme.of(context).dividerTheme.color!)),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.title.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizBoxH(size: 0.01),
                          Text(
                            data.subtitle.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget step6() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Find matches nearby📍") ?? "Find matches nearby📍",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            AppLocalizations.of(context)?.translate("Select your preferred distance range to discover matches conveniently. We'll help you find love close by.") ?? "Select your preferred distance range to discover matches conveniently. We'll help you find love close by.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              AppLocalizations.of(context)?.translate("Distance Preference") ?? "Distance Preference",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
            Text(
              "${onBordingProvider.kmCounter.toStringAsFixed(2)} km",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.black),
            )
          ]),
          const SizBoxH(size: 0.02),
          SliderTheme(
            data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
              value: onBordingProvider.kmCounter,
              max: 500,
              min: 10,
              activeColor: AppColors.appColor,
              inactiveColor: Theme.of(context).dividerTheme.color!,
              label: onBordingProvider.kmCounter.abs().toString(),
              onChanged: (double value) {
                onBordingProvider.updatekm(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget step7() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.translate("Discover like-minded people 🤗") ?? "Discover like-minded people 🤗",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizBoxH(size: 0.012),
            Text(
              AppLocalizations.of(context)?.translate("Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.") ?? "Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizBoxH(size: 0.018),
            TextField(
              controller: onBordingProvider.hobieSearchContoller,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
              ,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                hintText: AppLocalizations.of(context)?.translate("Search.") ?? "Search.",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                prefixIcon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                        child: SvgPicture.asset("assets/icons/Search.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),

                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),

                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),

                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (c) {
                onBordingProvider.searchHobie(c);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            onBordingProvider.hobieSearchContoller.text.isEmpty
                ? Wrap(
                    spacing: 13,
                    runSpacing: 13,
                    children: [
                      for (int a = 0;
                          a <
                              onBordingProvider
                                  .getInterestModel!.interestlist!.length;
                          a++)
                        Builder(builder: (context) {
                          Interestlist data = onBordingProvider
                              .getInterestModel!.interestlist![a];
                          return InkWell(
                            onTap: () {
                              if (onBordingProvider.selectHobi
                                      .contains(data.id) ==
                                  true) {
                                onBordingProvider.removeHobi(data.id);
                              } else {
                                if (onBordingProvider.selectHobi.length < 5) {
                                  onBordingProvider.addInHobi(data.id);
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                  color: onBordingProvider.selectHobi.contains(data.id)
                                      ? AppColors.appColor
                                      : Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: onBordingProvider.selectHobi
                                              .contains(data.id)
                                          ? Colors.transparent
                                          : Theme.of(context).dividerTheme.color!)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(data.title.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: onBordingProvider.selectHobi
                                                      .contains(data.id)
                                                  ? AppColors.white
                                                  : null)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.network(
                                    "${Config.baseUrl}${data.img}",
                                    height: 24,
                                    width: 24,
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    ],
                  )
                : onBordingProvider.searchForHobie.isEmpty
                    ? const SizedBox()
                    : Wrap(
                        spacing: 13,
                        runSpacing: 13,
                        children: [
                          for (int a = 0;
                              a < onBordingProvider.searchForHobie.length;
                              a++)
                            Builder(builder: (context) {
                              var result = onBordingProvider.searchForHobie[a];
                              Interestlist data = onBordingProvider
                                  .getInterestModel!.interestlist![result];
                              return InkWell(
                                onTap: () {
                                  if (onBordingProvider.selectHobi
                                          .contains(data.id) ==
                                      true) {
                                    onBordingProvider.removeHobi(data.id);
                                  } else {
                                    if (onBordingProvider.selectHobi.length < 5) {
                                      onBordingProvider.addInHobi(data.id);
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: onBordingProvider.selectHobi
                                              .contains(data.id)
                                          ? AppColors.appColor
                                          : Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: onBordingProvider.selectHobi
                                                  .contains(data.id)
                                              ? Colors.transparent
                                              : Theme.of(context).dividerTheme.color!)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(data.title.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: onBordingProvider
                                                          .selectHobi
                                                          .contains(data.id)
                                                      ? AppColors.white
                                                      : null)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.network(
                                        "${Config.baseUrl}${data.img}",
                                        height: 24,
                                        width: 24,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                        ],
                      )
          ],
        ),
      ),
    );
  }

  Widget step8() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.translate("Do you know which languages? 🗺️") ?? "Do you know which languages? 🗺️",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizBoxH(size: 0.012),
            Text(
              AppLocalizations.of(context)?.translate("Select your country of origin. We will verify your identity in the next step of your residence.") ?? "Select your country of origin. We will verify your identity in the next step of your residence.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizBoxH(size: 0.018),
            TextField(
              controller: onBordingProvider.languageContoller,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  ,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: AppLocalizations.of(context)?.translate("Search.") ?? "Search.",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                filled: true,
                fillColor: Theme.of(context).cardColor,
                prefixIcon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                        child: SvgPicture.asset("assets/icons/Search.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (c) {
                onBordingProvider.searchLanguage(c);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            onBordingProvider.languageContoller.text.isEmpty
                ? ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      Languagelist? data =
                          onBordingProvider.languageModel?.languagelist![i];
                      return InkWell(
                        onTap: () {
                          if (onBordingProvider.selectedLanguage
                                  .contains(data.id) ==
                              true) {
                            onBordingProvider.removelanguage(data.id);
                          } else {
                            onBordingProvider.addlanguage(data.id);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color: onBordingProvider.selectedLanguage
                                          .contains(data!.id)
                                      ? AppColors.appColor
                                      : Theme.of(context).dividerTheme.color!)),
                          child: Row(
                            children: [
                              Image.network(
                                "${Config.baseUrl}${data.img}",
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                data.title ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    ,
                              ),
                              const Spacer(),
                              onBordingProvider.selectedLanguage
                                      .contains(data.id)
                                  ? SvgPicture.asset(
                                      "assets/icons/Iconcheck.svg",
                                      height: 25,
                                      width: 25,
                                colorFilter: ColorFilter.mode( Theme.of(context).indicatorColor, BlendMode.srcIn),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (c, i) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemCount:
                        onBordingProvider.languageModel?.languagelist!.length ??
                            0)
                : onBordingProvider.searchForLanguage.isEmpty
                    ? const SizedBox()
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          var result = onBordingProvider.searchForLanguage[i];
                          Languagelist? data = onBordingProvider
                              .languageModel?.languagelist![result];
                          return InkWell(
                            onTap: () {
                              if (onBordingProvider.selectedLanguage
                                      .contains(data.id) ==
                                  true) {
                                onBordingProvider.removelanguage(data.id);
                              } else {
                                onBordingProvider.addlanguage(data.id);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: onBordingProvider.selectedLanguage
                                              .contains(data!.id)
                                          ? AppColors.appColor
                                          : Theme.of(context).dividerTheme.color!)),
                              child: Row(
                                children: [
                                  Image.network(
                                    "${Config.baseUrl}${data.img}",
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data.title ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        ,
                                  ),
                                  const Spacer(),
                                  onBordingProvider.selectedLanguage
                                          .contains(data.id)
                                      ? SvgPicture.asset(
                                          "assets/icons/Iconcheck.svg",
                                          height: 25,
                                          width: 25,
                                    colorFilter: ColorFilter.mode( Theme.of(context).indicatorColor, BlendMode.srcIn),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (c, i) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: onBordingProvider.searchForLanguage.length)
          ],
        ),
      ),
    );
  }

  Widget step9() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Discover religion 🤗") ?? "Discover religion 🤗",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            AppLocalizations.of(context)?.translate("Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.") ?? "Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          TextField(
            controller: onBordingProvider.religionSearchContoller,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                ,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: AppLocalizations.of(context)?.translate("Search.") ?? "Search.",
              hintStyle: Theme.of(context).textTheme.bodySmall,
              prefixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
                      child: SvgPicture.asset("assets/icons/Search.svg", colorFilter: ColorFilter.mode( Theme.of(context).indicatorColor, BlendMode.srcIn),))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (c) {
              onBordingProvider.searchReligion(c);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          onBordingProvider.religionSearchContoller.text.isEmpty
              ? Wrap(
                  spacing: 13,
                  runSpacing: 13,
                  children: [
                    for (int a = 0;
                        a <
                            onBordingProvider
                                .religionModel!.religionlist!.length;
                        a++)
                      Builder(builder: (context) {
                        Religionlist data =
                            onBordingProvider.religionModel!.religionlist![a];
                        return InkWell(
                          onTap: () {
                            onBordingProvider
                                .updatereligion(int.parse(data.id.toString()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: onBordingProvider.selectReligion ==
                                        int.parse(data.id.toString())
                                    ? AppColors.appColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: onBordingProvider.selectReligion ==
                                            int.parse(data.id.toString())
                                        ? Colors.transparent
                                        : Theme.of(context).dividerTheme.color!)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(data.title.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: onBordingProvider
                                                        .selectReligion ==
                                                    int.parse(
                                                        data.id.toString())
                                                ? AppColors.white
                                                : null)),
                              ],
                            ),
                          ),
                        );
                      })
                  ],
                )
              : onBordingProvider.searchForReligion.isEmpty
                  ? const SizedBox()
                  : Wrap(
                      spacing: 13,
                      runSpacing: 13,
                      children: [
                        for (int a = 0;
                            a < onBordingProvider.searchForReligion.length;
                            a++)
                          Builder(builder: (context) {
                            var result = onBordingProvider.searchForReligion[a];
                            Religionlist data = onBordingProvider
                                .religionModel!.religionlist![result];
                            return InkWell(
                              onTap: () {
                                onBordingProvider.updatereligion(
                                    int.parse(data.id.toString()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: onBordingProvider.selectReligion ==
                                            int.parse(data.id.toString())
                                        ? AppColors.appColor
                                        : Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: onBordingProvider
                                                    .selectReligion ==
                                                int.parse(data.id.toString())
                                            ? Colors.transparent
                                            : Theme.of(context).dividerTheme.color!)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(data.title.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: onBordingProvider
                                                            .selectReligion ==
                                                        int.parse(
                                                            data.id.toString())
                                                    ? AppColors.white
                                                    : null)),
                                  ],
                                ),
                              ),
                            );
                          })
                      ],
                    )
        ],
      ),
    );
  }

  Widget step10() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Search Preference 🌟") ?? "Search Preference 🌟",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            AppLocalizations.of(context)?.translate("Choose the gender that best represents you. Authenticity is key to meaningful connections.") ?? "Choose the gender that best represents you. Authenticity is key to meaningful connections.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (c, i) {
                return const SizBoxH(size: 0.012);
              },
              shrinkWrap: true,
              itemCount: onBordingProvider.searchPref.length,
              itemBuilder: (c, i) {
                return InkWell(
                  onTap: () {
                    onBordingProvider.updateMaleFemale1(i);
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: onBordingProvider.select1 == i
                                ? AppColors.appColor
                                : Theme.of(context).dividerTheme.color!)),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          onBordingProvider.searchPref[i],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onBordingProvider.select1 == i
                            ? SvgPicture.asset("assets/icons/verify.svg")
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget step11() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)?.translate("Show your best side 📸") ??
                "Show your best side 📸",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)?.translate(
                  "Add up to six photos or videos that show your personality.",
                ) ??
                "Add up to six photos or videos that show your personality.",
            style: const TextStyle(
              color: Color(0xFFB5A8BE),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _photoCountBadge(),
              const Spacer(),
              const Text(
                "Minimum 3 photos",
                style: TextStyle(
                  color: Color(0xFF9F92A8),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              final hasImage = onBordingProvider.images.length > index;
              return _premiumPhotoCard(index, hasImage);
            },
          ),
        ],
      ),
    );
  }

  Widget _photoCountBadge() {
    final count = onBordingProvider.images.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF311338), Color(0xFF21133A)],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF55315C)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.photo_library_outlined,
            color: Color(0xFFFF67AE),
            size: 16,
          ),
          const SizedBox(width: 7),
          Text(
            "$count / 6",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumPhotoCard(int index, bool hasImage) {
    return GestureDetector(
      onTap: () async {
        if (onBordingProvider.images.length < index) return;
        await onBordingProvider.pickupImage(index);
        if (mounted) setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF21142E),
              Color(0xFF120B19),
            ],
          ),
          border: Border.all(
            color: hasImage
                ? const Color(0xFFFF4FA3)
                : const Color(0xFF3A2945),
            width: hasImage ? 1.4 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x30000000),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasImage)
              Image.file(
                File(onBordingProvider.images[index].path.toString()),
                fit: BoxFit.cover,
              )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4FA3), Color(0xFF9B5CFF)],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x552B123D),
                          blurRadius: 18,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    index == 0 ? "Main photo" : "Add photo",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${index + 1}",
                    style: const TextStyle(
                      color: Color(0xFF81748D),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.38),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                  ),
                ),
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            if (hasImage)
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    onBordingProvider.removeImages(index);
                    setState(() {});
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.16),
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            if (hasImage)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 42,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xCC08050D),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 13, bottom: 10),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    index == 0 ? "Profile photo" : "Photo ${index + 1}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

}

