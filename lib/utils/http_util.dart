import 'package:http/http.dart' as http;

Future<http.Response> postData(
    {required String uri, Map<String, String>? headers, required String body}) {
  return http.post(
    Uri.parse(uri),
    headers: headers ??
        <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    body: body,
  );
}

Future<http.Response> getData(
    {required String uri, Map<String, String>? headers}) {
  return http.get(
    Uri.parse(uri),
    headers: headers ??
        <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
  );
}
