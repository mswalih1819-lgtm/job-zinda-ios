import 'dart:developer';
import 'package:dio/dio.dart';
import '../model/logged_in_user.dart';
import 'api_url.dart';

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(
    onResponse: (respons, handler) async {
        if (respons.data['statusCode'] == 401) {
          var options = respons.requestOptions;
          await _refreshToken();
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
          var options = e.response!.requestOptions;
          await _refreshToken();
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
  Future<bool> _refreshToken() async {
    log('---------------token expired------------------');
    final response = await post(Api.refreshTokenUrl, {'refreshToken': LoggedInUser.refreshToken});
       log('---------------${response.data}------------------');
    if (response.statusCode == 200 ) {
      Map<String,dynamic>data = response.data;
      if(data['status']){
        LoggedInUser.tokenUpdate(data['data']['tokens']);
      }
      return true;
    } else {
      LoggedInUser.clearUserData();
      return false;
    }
  }
  Future<Response> get(String url) async {
    return await dio.get(url, options: await options());
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

  Future<Options> options() async => Options(
        headers: await Api.getAuthorizationHeader(),
        validateStatus: (status) => true,
      );
}
