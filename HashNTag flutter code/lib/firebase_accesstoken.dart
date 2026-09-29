// import 'package:googleapis_auth/auth_io.dart';
// import 'package:dating/core/config.dart';
//
// class FirebaseAccesstoken {
//   static String firebaseMessageScope = "https://www.googleapis.com/auth/firebase.messaging";
//
//   Future<String> getAccessToken() async {
//     final credentials = ServiceAccountCredentials.fromJson({
//       "type": "service_account",
//       "project_id": "********-******",
//       "private_key_id": "****************",
//       "private_key": "*****************",
//       "client_email": "firebase-adminsdk-1fgos@********-******.iam.gserviceaccount.com",
//       "client_id": "**********",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-1fgos%******-********.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     });
//
//     final client = await clientViaServiceAccount(credentials, [firebaseMessageScope]);
//
//     final accessToken = client.credentials.accessToken.data;
//     Config.firebaseKey = accessToken;
//     print("+++++++++++++++++:---- ${Config.firebaseKey}");
//     return accessToken;
//   }
//
// }





import 'package:googleapis_auth/auth_io.dart';
import 'package:dating/core/config.dart';

class FirebaseAccesstoken {
  static String firebaseMessageScope = "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final credentials = ServiceAccountCredentials.fromJson({
       "type": "service_account",
       "project_id": "gomeet-56982",
       "private_key_id": "a976555ace5e50c5b8a294b7416ae265f4d041ad",
       "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDAWLfsVubwP96H\na60zeJ2tHBF/6vAIpe0pg45yuCtgRnwgNKDutzVyuKmgssYllwFJdNSlhJ1TKo5Q\n8peLajjUO7oG2ZWfMkvljTY62dy3RX+IAYqyAahg8zMN2bwWtdIhDrJI5ahra3C8\n47PR+MBcToZLy8dN6CHgdsemqIywH/YgB6tD8ugT9Mo5/J715m98xk2fH0Kkg19j\nM87bkbevjU23BKg1j+YcbUhxRQaQ2w0F4+BU3poCDbEpmC2V+5F5kokId5tZ+eTR\nZKaflIzCpxiIUr+PiCvJcwaDKxGHQmMMZrD21m14WAIf3j58Aj73MSm/20uSGssN\ngxixW+ndAgMBAAECggEAHDfHv8Hd/mf4Tviif7cVtrQz8wa18SbafKkiqDzRjD26\n7wSZiXvSOQLTS9J+VDxrgWnE2oVyiSVonIKCbf8G2Efs2h1ooGLCFKqbRpX4leB5\nvauwO74XhCWZm1ISkGhbK+Naj2w1wZCRCP0Ev+yU19XjSNJb6leARMxYLOB0R1Af\n5vQq4au2vAWOK8RhnV3tMEJ2rSo7InC/TdtV3u7ovpRKvUUAPAnI4J3IuRN/c6+d\nzGXJqeXL2pYJo6uWjm7cfFX+QcP65HgZCTIVpIsX+jDM1GvWXKNRQS604+4OvI1S\nO+EkL3XJJrI/XuDMJ07rlhd3cRdeyB2vCZYfmquHZwKBgQDl0HEkf8GogviIz7vC\nKcWIuSAr74I+RAI4V46jjf/A6NEqNtDwvK3K8M7DnUHtb3wXnfU5hZZRGyLtcuiO\nRwKAM/SU/LFZ7OISIz3tERKLdDXmvC5e063p2uT3rWY1Rt7NefvnwWkOlhHO51dI\nBM/L3+zXF1qlAqyIvUh5t8LzwwKBgQDWQ11WUuhY/QO0r4i0LBABZijQ3w0DZond\nvXdaL15KZaCVyw5OcXDMraHCHNfGtAp5KqYvo1mLmrp1R6XN7ktioxpgUMiso47G\nyKQxZh9d60BSNZCo/D5t2ij7ZOM1x7CUkW9uOTIVealeVsifa8JQqZ4ldVF1aID1\nxLqOVsXx3wKBgQDhneW2A4bIPOxqxCZ81C2NsNGY0KZ5IqNbVPpAL6Qqa2cNnos6\nDMJCPm9/M+AJji2xse2R70hHj/CWVP1i0OvvmRJBQmOK+ThovhiJqP0f05MnVw/f\nIMnYkIHBdoalP1J1P5DDUeol28bX7d6OYcrvSINoFxFydlGUXN/OP04xqQKBgQC7\nWZIOvlXuIeaQooA9Ut336zU7Vh4R4CIi4t2u3QZstSpScIgk7Sp9vkFX81J1q84Q\nnstLkmDlIjlx/WEsjPYb3JReraSa2DUq+hwgGbTJsb+/YpkIOe/4rC7ziwblaqOr\ndPPjhF2Xy5beJ7IrO9VgJMBk7o14xRUmUYvylEtnLwKBgEdo9IsFjvYGY+CC17FP\nFR7Y6JXxnwLw/uB2BDl6cwL+ALfHparFOIvUEBksiJTMYHuP7D0+B0XS+LCKbRhG\nX43EYTeJ/ZAV8tdSu4aRS03HqkgatcXjFodGl7JUag/k8b+IgbN/1RNiqZBlCzsY\nmL/TZfkAXVRwgOi+lQSNWLpm\n-----END PRIVATE KEY-----\n",
       "client_email": "firebase-adminsdk-fbsvc@gomeet-56982.iam.gserviceaccount.com",
       "client_id": "113340927335837608726",
       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
       "token_uri": "https://oauth2.googleapis.com/token",
       "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
       "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40gomeet-56982.iam.gserviceaccount.com",
       "universe_domain": "googleapis.com"
     });
    print("+++++++++++++++++1:---- ${credentials.toString()}");
    try{
      final client = await clientViaServiceAccount(credentials, [firebaseMessageScope]);
      print("+++++++++++++++++2:---- ${client.credentials.accessToken.data}");

      final accessToken = client.credentials.accessToken.data;
      Config.firebaseKey = accessToken;
      print("+++++++++++++++++3:---- ${Config.firebaseKey}");
      return accessToken;

    }catch(e){
      print("Error --${e.toString()}");
      return "";
    }

  }
}