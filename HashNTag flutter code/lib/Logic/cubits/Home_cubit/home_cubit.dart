import 'dart:convert';
import 'package:dating/Logic/cubits/Home_cubit/homestate.dart';
import 'package:dating/core/api.dart';
import 'package:dating/core/config.dart';
import 'package:dating/data/localdatabase.dart';
import 'package:dating/data/models/homemodel.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../presentation/screens/other/premium/premium_provider.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomeInitState());

  final Api _api = Api();

  initforHome(context) {
    emit(HomeLoadingState());
    try {
      double? lat = Provider.of<OnBordingProvider>(context, listen: false).lat;
      double? long = Provider.of<OnBordingProvider>(context, listen: false).long;
      Preferences.fetchUserDetails().then((value) {
        Map uid = jsonDecode(value);
        getHomeData(
                uid: uid["UserLogin"]["id"],
                lat: (lat).toString(),
                long: (long).toString(),context: context
        );
      });
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  Future<HomeModel> getHomeData({required String uid, required String lat, required String long,required context}) async {
    try {
      Map data = {
        "uid": uid,
        "lats": lat,
        "longs": long
      };

      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.homeData}", data: data);

      if (response.statusCode == 200) {
        HomeModel homeData = HomeModel.fromJson(response.data);

        Preferences.setDatawithKeyFromLocal(key: "currency", data: response.data["currency"]);

        print(homeData.plandata!.amount!);
        emit(HomeCompleteState(homeData));
        try{
          Provider.of<PremiumProvider>(context,listen: false).selectedPlan = int.parse(homeData.planId.toString());
          Provider.of<HomeProvider>(context,listen: false).currency = homeData.currency;
        } catch(e){
          // emit(HomeErrorState("e.toString()"));
          print("***:- ${e.toString()}");
        }

        return HomeModel.fromJson(response.data);
      } else {
        emit(HomeErrorState(response.data["ResponseMsg"]));
        return HomeModel.fromJson(response.data);
      }
    } catch (e) {
      emit(HomeErrorState(e.toString()));
      rethrow;
    }
  }
Future delUnlikeApi(BuildContext context) async {
  try {
    Map<String, dynamic> data = {
      "uid": Provider.of<HomeProvider>(context, listen: false).uid,
    };

    print("========== DELETE UNLIKE REQUEST ==========");
    print("URL: ${Config.baseUrlApi}${Config.delUnlike}");
    print("DATA: $data");

    Response response = await _api.sendRequest.post(
      "${Config.baseUrlApi}${Config.delUnlike}",
      data: data,
      options: Options(
        responseType: ResponseType.plain, // Get raw response
      ),
    );

    print("========== STATUS CODE ==========");
    print(response.statusCode);

    print("========== RAW RESPONSE ==========");
    print(response.data);

    if (response.statusCode == 200) {
      initforHome(context);
      Navigator.pop(context);
    }
  } on DioException catch (e) {
    print("========== DIO ERROR ==========");
    print("Message: ${e.message}");
    print("Response: ${e.response?.data}");
    print("Status Code: ${e.response?.statusCode}");

    emit(HomeErrorState(e.toString()));
  } catch (e) {
    print("========== GENERAL ERROR ==========");
    print(e);

    emit(HomeErrorState(e.toString()));
  }
}
  // Future<void> delUnlikeApi(BuildContext context) async {
  //   try {
  //
  //     final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  //     String uid = homeProvider.uid;
  //
  //     Map<String, dynamic> data = {
  //       "uid": uid,
  //     };
  //
  //     Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.delUnlike}", data: data);
  //
  //     if (response.statusCode == 200) {
  //       initforHome(context);
  //       Navigator.pop(context);
  //     }
  //   } catch (e) {
  //     emit(HomeErrorState(e.toString()));
  //     rethrow;
  //   }
  // }
Future profileLikeDislikeApi({
  required String uid,
  required String proId,
  required String action,
  String? lat,
  String? long,
}) async {
  try {
    Map<String, dynamic> data = {
      "uid": uid,
      "profile_id": proId,
      "action": action,
    };

    print("========== REQUEST ==========");
    print(data);

    print("========== URL ==========");
    print("${Config.baseUrlApi}${Config.likeDislike}");

    Response response = await _api.sendRequest.post(
      "${Config.baseUrlApi}${Config.likeDislike}",
      data: data,
    );

    print("========== STATUS ==========");
    print(response.statusCode);

    print("========== RESPONSE ==========");
    print(response.data);

    if (response.statusCode == 200) {
      if (response.data != null &&
          response.data["Result"].toString() == "true") {
        print("✅ Like Success");
      } else {
        Fluttertoast.showToast(
          msg: response.data["ResponseMsg"]?.toString() ??
              "Unknown server response",
        );
      }
    }
  } on DioException catch (e) {
    print("\n========== DIO ERROR ==========");
    print("Type       : ${e.type}");
    print("Message    : ${e.message}");
    print("StatusCode : ${e.response?.statusCode}");
    print("Headers    : ${e.response?.headers}");
    print("Response   : ${e.response?.data}");
    print("Request    : ${e.requestOptions.uri}");
    print("Method     : ${e.requestOptions.method}");
    print("Data Sent  : ${e.requestOptions.data}");
    print("===============================\n");

    emit(HomeErrorState(e.toString()));
  } catch (e, stackTrace) {
    print("\n========== OTHER ERROR ==========");
    print(e);
    print(stackTrace);
    print("=================================\n");

    emit(HomeErrorState(e.toString()));
  }
}

  Future filterHome({required String uid, required String lat, required String long, required String radiusSearch, required String searchPreference, required String minage, required String maxage, required String relationGoal, required String interest, required String religion, required String language, required String isverify,}) async {
    try {
      Map data = {
        "uid": uid,
        "radius_search": radiusSearch,
        "search_preference": searchPreference,
        "lats": lat,
        "longs": long,
        "minage":minage,
        "maxage":maxage,
        "relation_goal":relationGoal,
        "interest":interest,
        "religion":religion,
        "language":language,
        "is_verify":isverify
      };

      Response response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.filter}", data: data);

      if (response.statusCode == 200) {
        if (response.data["Result"] == "true") {
          HomeModel homeData = HomeModel.fromJson(response.data);
          emit(HomeCompleteState(homeData));
        } else {
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }
      }
    } catch (e) {
      emit(HomeErrorState(e.toString()));
      rethrow;
    }
  }

  Future planDataApi(context,uid) async {
    Map data = {
      "uid": uid
    };
    try{
      Response  response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.userInfo}",data: data);
      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
         return response.data["direct_chat"];
        }
      }
    }catch(e){
      print(e);
    }
  }

}
