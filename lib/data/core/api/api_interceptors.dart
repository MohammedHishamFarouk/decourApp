import 'package:decourapp/data/core/api/end_points.dart';
import 'package:decourapp/data/core/cache/cache_helper.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = CacheHelper().getData(key: ApiKey.accessToken)  != null?
    'Bearer ${CacheHelper().getData(key: ApiKey.accessToken)}':null;
    super.onRequest(options, handler);
  }
}