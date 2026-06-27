import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../model/logged_in_user.dart';
import 'api_url.dart';

class ApiService {
  final Dio dio = Dio();
  static Completer<bool>? _refreshCompleter; // single in-flight refresh

  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(
    onResponse: (respons, handler) async {
        final dynamic data = respons.data;
        bool shouldRefresh = false;
        if (data is Map<String, dynamic>) {
          final dynamic statusCodeField = data['statusCode'] ?? data['code'];
          final bool unauthorized = statusCodeField == 401 || statusCodeField == '401';
          final bool statusFalse = data['status'] == false;
          shouldRefresh = unauthorized || (statusFalse && unauthorized);
        }
        if (shouldRefresh) {
          // Do not attempt refresh before login
          if (LoggedInUser.accessToken == null || LoggedInUser.refreshToken == null) {
            return handler.next(respons);
          }

          var options = respons.requestOptions;
          final ok = await _ensureRefreshed();
          if (!ok) {
            // Refresh failed -> logout and propagate original response
            LoggedInUser.clearUserData();
            return handler.next(respons);
          }
          // Retry the failed request with the new token
          options.headers['Authorization'] =
              'Bearer ${LoggedInUser.accessToken}';
          final response = await dio.request(
            options.path,
            options: Options(
              method: options.method,
              headers: options.headers,
            ),
            data: options.data,
            queryParameters: options.queryParameters,
          );
          return handler.resolve(response);
        } else {
          return handler.next(respons);
        }
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Do not attempt refresh before login
          if (LoggedInUser.accessToken == null || LoggedInUser.refreshToken == null) {
            return handler.next(e);
          }

          var options = e.response!.requestOptions;
          final ok = await _ensureRefreshed();
          if (!ok) {
            // Refresh failed -> logout and stop retries
            LoggedInUser.clearUserData();
            return handler.next(e);
          }
          // Retry the failed request with the new token
          options.headers['Authorization'] =
              'Bearer ${LoggedInUser.accessToken}';
          final response = await dio.request(
            options.path,
            options: Options(
              method: options.method,
              headers: options.headers,
            ),
            data: options.data,
            queryParameters: options.queryParameters,
          );
          return handler.resolve(response);
        } else {
          return handler.next(e);
        }
      },
        ));
        
  }
  Future<bool> _ensureRefreshed() async {
    // Single in-flight refresh using a completer
    if (_refreshCompleter != null) {
      try {
        return await _refreshCompleter!.future;
      } catch (_) {
        return false;
      }
    }
    _refreshCompleter = Completer<bool>();
    try {
      final ok = await _refreshToken();
      _refreshCompleter!.complete(ok);
      return ok;
    } catch (e) {
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      // allow subsequent refreshes later
      _refreshCompleter = null;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      log('---------------token expired------------------');
      final response = await post(Api.refreshTokenUrl, {'refreshToken': LoggedInUser.refreshToken});
      log('---------------${response.statusCode} ${response.data}------------------');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data is Map<String, dynamic>
            ? response.data
            : <String, dynamic>{};
        // Backend global error handler returns {status:false, message, ...} with proper codes now
        final bool status = (data['status'] == true);
        if (status && data['data'] != null && data['data']['tokens'] != null) {
          LoggedInUser.tokenUpdate(data['data']['tokens']);
          return true;
        }
        // If backend responded with status false, treat as failure
        return false;
      }
      // 404 Token Not found or any other -> logout by caller
      return false;
    } catch (e) {
      return false;
    }
  }
  Future<Response> get(String url) async {
    final requestOptions = await options();
    return await dio.get(url, options: requestOptions);
  }

  Future<Response> post(String url, Object? data) async {
    return await dio.post(url, data: data, options: await options());
  }

  Future<Response> put(String url, [Object? data]) async {
    return await dio.put(url, data: data, options: await options());
  }

  Future<Response> delete(String url, [Object? data]) async {
    return await dio.delete(url, data: data, options: await options());
  }

  Future<Response> patch(String url) async {
    return await dio.patch(url, options: await options());
  }

  Future<Options> options() async {
    if (LoggedInUser.isGuest) {
      return Options(validateStatus: (status) => true);
    }
    return Options(
      headers: await Api.getAuthorizationHeader(),
      validateStatus: (status) => true,
    );
  }
}
