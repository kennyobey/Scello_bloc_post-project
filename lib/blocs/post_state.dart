import 'package:equatable/equatable.dart';

import '../models/post_model.dart'; // Adjust the import based on your project structure

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<Post> posts;

  PostLoadedState(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostEditSuccessState extends PostState {}

class PostEditingState extends PostState {}

class PostDetailState extends PostState {
  final Post post;
  final List<Comment> comments;

  PostDetailState(this.post, this.comments);

  @override
  List<Object> get props => [post, comments];
}

class PostCreationSuccessState extends PostState {}

class PostUpdateSuccessState extends PostState {}


class PostCreatingState extends PostState {}

class PostErrorState extends PostState {
  final String message;

  PostErrorState(this.message);

  @override
  List<Object> get props => [message];
}
