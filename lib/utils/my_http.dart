import 'package:http/http.dart' as http;
import 'package:one_lead/utils/url.dart';

class MyHttp {
  static Future<http.Response> put(String endPoint, dynamic data) async {
    var url = Uri.parse(MyUrl.url(endPoint));
    var res = await http.put(url, body: data);
    return res;
  }

  static Future<http.Response> patch(String endPoint, dynamic data) async {
    var url = Uri.parse(MyUrl.url(endPoint));
    var res = await http.patch(url, body: data);
    return res;
  }

  static Future<http.Response> delete(String endPoint) async {
    var url = Uri.parse(MyUrl.url(endPoint));
    var res = await http.delete(url);
    return res;
  }

  static Future<http.Response> post(String endPoint, dynamic data) async {
    var url = Uri.parse(MyUrl.url(endPoint));
    var res = await http.post(url, body: data);
    return res;
  }

  static Future<http.Response> get(String endPoint) async {
    var url = Uri.parse(MyUrl.url(endPoint));
    var res = await http.get(url);
    return res;
  }
}
