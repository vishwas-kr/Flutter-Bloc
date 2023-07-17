import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../models/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    var client = http.Client();
    List<PostModel> posts = [];
    emit(PostFetchingLoadingState());
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostModel post = PostModel.fromJson(result[i]);
        posts.add(post);
      }
      emit(PostSuccessfulState(post: posts));
    } catch (e) {
      emit(PostFetchingErrorState());
      log(e.toString());
    }
  }
}
