import 'package:dio/dio.dart';

import 'DInterceptor.dart';

class Http {
  static final Http _instance = Http._internal();

  // 单例模式使用Http类，
  factory Http() => _instance;

  static late final Dio dio;
  final CancelToken _cancelToken = CancelToken();

  Http._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions();

    dio = Dio(options);

    // 添加request拦截器
    dio.interceptors.add(RequestInterceptor());
    // 添加error拦截器
    dio.interceptors.add(ErrorInterceptor());
    // 添加cache拦截器
    // dio.interceptors.add(NetCacheInterceptor());
    // 添加retry拦截器
    // dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );
  }

  // 初始化公共属性
  // [baseUrl] 地址前缀
  // [connectTimeout] 连接超时赶时间
  // [receiveTimeout] 接收超时赶时间
  // [interceptors] 基础拦截器
  void init({
    String? baseUrl,
    int connectTimeout = 1500,
    int receiveTimeout = 1500,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers ?? const {},
    );
    // 在初始化http类的时候，可以传入拦截器
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  // 关闭dio
  void cancelRequests({required CancelToken token}) {
    _cancelToken.cancel("cancelled");
  }

  // 添加认证
  // 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, dynamic>? headers;
    // 从getx或者sputils中获取
    // String accessToken = Global.accessToken;
    String accessToken =
        "7a7e95db7913caf62c6ac4223ca4fe87bdcdef629f91138e7ea27e248976153c";
    headers = {
      'token': accessToken,
    };
    return headers;
  }

  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = true,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    Response response;
    response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );

    return response.data;
  }

  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }
}
