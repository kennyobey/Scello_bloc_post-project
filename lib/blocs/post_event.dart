import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends PostEvent {}

class FetchPostDetailEvent extends PostEvent {
  final int postId;

  FetchPostDetailEvent(this.postId);

  @override
  List<Object> get props => [postId];
}

class CreatePostEvent extends PostEvent {
  final String title;
  final String body;

  CreatePostEvent(this.title, this.body);

  @override
  List<Object> get props => [title, body];
}

class UpdatePostEvent extends PostEvent {
  final int postId;
  final String title;
  final String body;

  UpdatePostEvent(this.postId, this.title, this.body);

  @override
  List<Object> get props => [postId, title, body];
}


class EditPostEvent extends PostEvent {
  final int postId;
  final String title;
  final String body;

  EditPostEvent(this.postId, this.title, this.body);
}