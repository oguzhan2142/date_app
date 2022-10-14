import 'package:dio/dio.dart';

class TokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZWplY3RVc2VycyI6W10sImJsb2NrZWRVc2VycyI6W10sImFjY2VwdGVkVXNlcnMiOltdLCJyZW1vdmVkVXNlcnMiOltdLCJfaWQiOiI2MzQ0OTI5OGViNTI1NmY5ZGI3YTk4NDgiLCJ1c2VybmFtZSI6Imt1bGxhbmljaTExIiwicGFzc3dvcmQiOiIxMjMiLCJfX3YiOjAsImlhdCI6MTY2NTczNDgwMCwiZXhwIjoxNjY1NzQyMDAwfQ.A5gGZ9KK44cTlkRgvtnUQ8wAXQ_geIypMql2bj9N9tw';
    super.onRequest(options, handler);
  }
}
