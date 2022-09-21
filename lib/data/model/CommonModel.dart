class BaseResponse<T> {
  String msg;
  int code;
  T data;

  BaseResponse({required this.data, required this.code, required this.msg});

  static BaseResponse fromMap(Map<String, dynamic> map) {
    return BaseResponse(msg: map['msg'], code: map['code'], data: map['data']);
  }
}

abstract class JsonObject {
  // JsonObject fromMap(Map<String, dynamic> map);

  JsonObject fromJsonString(String str);
}
