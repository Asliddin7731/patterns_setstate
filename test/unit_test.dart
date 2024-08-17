import 'package:flutter_test/flutter_test.dart';
import 'package:patterns_setstate/model/post_model.dart';
import 'package:patterns_setstate/service/http_service.dart';

void main(){

  test('Post is not null', ()async{
    var response = await Network.GET(Network.apiList, Network.paramsEmpty());
    List<Post> posts =Network.parsePostList(response!);
    expect(posts, isNotNull);
  });

  test('Posts is greater than zero', ()async{
    var response = await Network.GET(Network.apiList, Network.paramsEmpty());
    List<Post> posts =Network.parsePostList(response!);
    expect(posts.length, greaterThan(0));
  });

  test('Posts is exactly 100', ()async{
    var response = await Network.GET(Network.apiList, Network.paramsEmpty());
    List<Post> posts =Network.parsePostList(response!);
    expect(posts.length, equals(100));
  });

  test("Check post's title", ()async{
    var response = await Network.GET(Network.apiList, Network.paramsEmpty());
    List<Post> posts =Network.parsePostList(response!);
    expect(posts[1].title?.toUpperCase(), equals( 'QUI EST ESSE'));
  });
}

