import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_learn/features/api/post/repo/post_repo.dart';
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
    emit(PostFetchingLoadingState());
    List<PostModel> posts = await PostRepo.fetchPost();
    emit(PostSuccessfulState(post: posts));
  }
}
