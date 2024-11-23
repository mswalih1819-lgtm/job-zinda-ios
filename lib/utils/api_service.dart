import 'package:dio/dio.dart';

import 'api_url.dart';

class ApiService {
  final Dio dio = Dio();

  // ApiService() {
  //   dio.interceptors.add(InterceptorsWrapper(

  //       ));
  // }

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
