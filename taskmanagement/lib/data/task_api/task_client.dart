import 'package:dio/dio.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TaskHttpClient {
  //
  final _dio = Dio();

  final Function onUnAuthorized;

  TaskHttpClient({
    required String server,
    required bool logger,
    required this.onUnAuthorized,
  }) {
    _dio.options.baseUrl = server;
    _dio.options.connectTimeout = const Duration(minutes: 1);
    _dio.options.sendTimeout = const Duration(minutes: 1);
    _dio.options.receiveTimeout = const Duration(minutes: 1);
    if (logger) addLogger();
    addErrorInterceptor();
    addResponseInterceptor();
  }

  void addErrorInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          exceptionHandler(error);
          // if (error.response != null) {
          //   error.response!.data = ShopResponse.fromMap(error.response!.data);
          // }
          handler.next(error);
        },
      ),
    );
  }

  void addResponseInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }

  void addLogger() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  Map<String, dynamic>? nullKiller(Map<String, dynamic>? map) {
    Map<String, dynamic>? temp = {};
    map?.forEach(
      (key, value) {
        if (value != null) {
          if (value == '') {
            temp[key] = null;
          } else if (value.runtimeType == Map) {
            temp[key] = nullKiller(value);
          } else {
            temp[key] = value;
          }
        }
      },
    );
    return temp;
  }

  Map<String, dynamic>? qpNullKiller(Map<String, dynamic>? map) {
    Map<String, dynamic>? temp = {};
    map?.forEach(
      (key, value) {
        if (value != null && value != '') {
          if (value.runtimeType == Map) {
            temp[key] = qpNullKiller(value);
          } else {
            temp[key] = value;
          }
        }
      },
    );
    return temp;
  }

  void exceptionHandler(DioException error) async {
    //
    final int? statusCode = error.response?.statusCode;
    if (error.message?.contains('The connection errored: Failed host lookup:') ?? false) {
      toast('عدم اتصال به شبکه');
      throw Exception('network Error! can\'t connect to network.');
    } else if (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout || error.type == DioExceptionType.sendTimeout) {
      toast('سرویس پاسخگو نبود');
      throw Exception(
        'connection timeout! (${error.requestOptions.connectTimeout})ms',
      );
    } else if (error.type == DioExceptionType.unknown) {
      toast('مشکلی در برقراری ارتباط با سرویس رخ داد');
      throw Exception(error.message);
    } else if (error.type == DioExceptionType.connectionError || error == 'The remote computer refused the network connection.') {
      // toast('مشکلی در سرور وجود دارد لطفا با تیم فنی تماس بگیرید ');
    } else if (statusCode == 401) {
      onUnAuthorized();
      await Future.delayed(const Duration(milliseconds: 50));
      toast('کلید دسترسی شما منقضی شده است');
      throw Exception('access token expired! (401)');
    } else if (statusCode == 403) {
      toast('دسترسی مجاز نمی باشد');
      throw Exception('access denied! (403)');
    } else if (statusCode == 500) {
      toast('مشکلی در سرویس رخ داده');
      throw Exception('internal server error! (500)');
    } else if (statusCode == 502) {
      toast('سرویس در دسترس نمی باشد');
      throw Exception(error);
    } else if (error.response?.data['message']?['general'] != null && error.response?.data['message']?['general'] != '') {
      toast(error.response?.data['message']?['general']);
    }
  }

  Options _buildReqOptions({String? accessToken}) {
    return Options(
      headers: {
        "Accept-language": "fa",
        "Accept": "application/json",
        "content": "application/json",
        if (accessToken != null) "Authorization": 'JWT $accessToken',
      },
    );
  }

  Future<Map<String, dynamic>> get(
    String url, {
    String? param,
    String? accessToken,
    Map<String, dynamic>? queryParams,
  }) async {
    final res = await _dio.get(
      param == null ? url : '$url/$param/',
      queryParameters: qpNullKiller(queryParams),
      options: _buildReqOptions(
        accessToken: "$accessToken",
      ),
    );
    return res.data;
  }

  Future<List<dynamic>> getList(
    String url, {
    String? param,
    String? accessToken,
    Map<String, dynamic>? queryParams,
  }) async {
    final res = await _dio.get(
      param == null ? url : '$url/$param',
      queryParameters: qpNullKiller(queryParams),
      options: _buildReqOptions(
        accessToken: "$accessToken",
      ),
    );
    return res.data;
  }

  Future<Map<String, dynamic>> post(
    String url, {
    String? accessToken,
    String? param,
    String? extraParam,
    Map<String, dynamic>? data,
  }) async {
    if (param == null) {
      url = '$url';
    } else if (extraParam != null) {
      url = '$url/$param/$extraParam/';
    }
    try {
      final res = await _dio.post(
        url,
        data: nullKiller(data),
        options: _buildReqOptions(
          accessToken: accessToken,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        rethrow;
      }
    }
  }

  Future<Map<dynamic, dynamic>> postImage(
    String url, {
    String? accessToken,
    FormData? data,
  }) async {
    try {
      final res = await _dio.post(
        url,
        data: data,
        options: _buildReqOptions(
          accessToken: accessToken,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.data is Map<dynamic, dynamic>) {
          // If the response data is a Map, return it
          return e.response!.data;
        } else {
          // If the response data is a String, consider it as an error message
          throw Exception(e.response!.data.toString());
        }
      } else {
        rethrow;
      }
    }
  }

  Future<Map<String, dynamic>> put(
    String url, {
    String? param,
    String? accessToken,
    Map<String, dynamic>? data,
  }) async {
    try {
      final res = await _dio.put(
        param == null ? url : '$url/$param',
        data: nullKiller(data),
        options: _buildReqOptions(
          accessToken: accessToken,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        rethrow;
      }
    }
  }

  Future<Map<String, dynamic>> patch(
    String url, {
    String? param,
    String? id,
    String? accessToken,
    Map<String, dynamic>? data,
  }) async {
    try {
      final res = await _dio.patch(
        '$url/$id/',
        data: nullKiller(data),
        options: _buildReqOptions(
          accessToken: accessToken,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        rethrow;
      }
    }
  }

  Future<Map<String, dynamic>> delete(
    String url, {
    String? accessToken,
    String? id,
  }) async {
    final res = await _dio.delete(
      '$url/$id/',
      options: _buildReqOptions(
        accessToken: accessToken,
      ),
    );
    return res.data;
  }
}
