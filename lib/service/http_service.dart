
import 'dart:convert';

import 'package:http/http.dart';
import 'package:patterns_setstate/service/log_service.dart';

import '../model/post_model.dart';

class Network {
  static String BASE = 'jsonplaceholder.typicode.com';
  static Map<String, String> headers = {
    'Content-True': 'application/json; charset=UTF-8'
  };

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params)async{
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    LogService.d('api : $api');
    LogService.w('params : $params');
    LogService.i('response : ${response.body}');

    if (response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  static Future<String?> POST(String api, Map<String, String> params)async{
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    LogService.d('api : $api');
    LogService.w('params : $params');
    LogService.i('response : ${response.body}');

    if (response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  static Future<String?> PUT(String api, Map<String, String> params)async{
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    LogService.d('api : $api');
    LogService.w('params : $params');
    LogService.i('response : ${response.body}');

    if (response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  static Future<String?> DEl(String api, Map<String, String> params)async{
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    LogService.d('api : $api');
    LogService.w('params : $params');
    LogService.i('response : ${response.body}');

    if (response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }


  /* Http Api */

  static String apiList = '/posts';
  static String apiCreate = '/posts';
  static String apiUpdate = '/posts/'; //{id}
  static String apiDelete = '/posts/'; //{id}


  /* Http Params */
  static Map<String, String> paramsEmpty(){
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Post post){
    Map<String, String> params = {};

    params.addAll({
    'title' : post.title!,
    'body' : post.body!,
     'userId' : post.userId.toString()
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post){
    Map<String, String> params = {};

    params.addAll({
      'id' : post.id.toString(),
      'title' : post.title!,
      'body' : post.body!,
      'userId' : post.userId.toString()
    });
    return params;
  }

  /* Http Params */

  static List<Post> parsePostList (String response) {
    dynamic json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }

}

