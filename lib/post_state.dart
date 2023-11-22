import 'package:api_calling_using_riverpod/http_get_service.dart';
import 'package:api_calling_using_riverpod/post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, PostState>((ref) => PostsNotifier());

@immutable
abstract class PostState{}

class InitialPostState extends PostState{}

class PostsLoadingPostState extends PostState{}

class PostsLoadedPostState extends PostState{
  PostsLoadedPostState({
    required this.posts,
});

  final List<Post> posts;
}

class ErrorPostState extends PostState{
  ErrorPostState(String string);

  String get message => 'error msg';

}

class PostsNotifier extends StateNotifier<PostState>{
  PostsNotifier(): super(InitialPostState());
final HttpGetPost _httpGetPost = HttpGetPost();

 void fetchPosts() async{
    try{
      state = PostsLoadingPostState();
      List<Post> posts = await _httpGetPost.getPost();
      state = PostsLoadedPostState(posts: posts);
    }
    catch(e){
      state = ErrorPostState(e.toString());
    }
  }

}