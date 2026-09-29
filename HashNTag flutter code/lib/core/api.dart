// Imports the Config class that contains API configuration
// like Base URL and request headers.
import 'package:dating/core/config.dart';

// Imports the Dio package.
// Dio is an HTTP client used to make API requests
// such as GET, POST, PUT, and DELETE.
import 'package:dio/dio.dart';

// Imports PrettyDioLogger.
// This package prints API requests and responses
// in the console, making debugging easier.
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Api class is responsible for handling
// all HTTP requests in the application.
class Api {

  // Create an instance of Dio.
  // This object is used to communicate with the backend server.
  final Dio _dio = Dio();

  // Constructor
  // This runs automatically whenever
  // Api() is called.
  Api() {

    // Sets the base URL for every API request.
    // Example:
    // Config.baseUrl = https://example.com/api/
    //
    // Instead of writing:
    // https://example.com/api/login
    //
    // You only need to write:
    // login
    _dio.options.baseUrl = Config.baseUrl;

    // Sets default headers that are sent
    // with every request.
    //
    // Example:
    // Authorization Token
    // Content-Type
    // Accept
    _dio.options.headers = Config.header;

    // Response Decoder
    //
    // Dio uses this to decode server responses.
    // Here it is not assigned to anything,
    // so this line currently has no effect.
    // It can be removed unless you plan to
    // customize the response decoding.
    _dio.options.responseDecoder;

    // Adds an interceptor to Dio.
    // Interceptors allow you to inspect
    // every request and response.
    _dio.interceptors.add(

      // PrettyDioLogger prints API details
      // in a readable format.
      PrettyDioLogger(

        // Prints request body.
        //
        // Example:
        // {
        //   "email":"abc@gmail.com"
        // }
        requestBody: true,

        // Prints any API errors.
        error: true,

        // Prints the response received
        // from the server.
        responseBody: true,

      ),
    );
  }

  // Getter
  //
  // Returns the configured Dio instance.
  //
  // Usage:
  // Api().sendRequest.get(...)
  Dio get sendRequest => _dio;

}