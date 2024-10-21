import 'package:bloc/bloc.dart';
import '../repositories/post_repositories.dart';
import 'post_event.dart';
import 'post_state.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostLoadingState()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final posts = await postRepository.fetchPosts();
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState('Failed to fetch posts'));
      }
    });

    on<FetchPostDetailEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final posts = await postRepository.fetchPosts();
        final comments = await postRepository.fetchComments(event.postId);
        emit(PostDetailState(
            posts.firstWhere((p) => p.id == event.postId), comments));
      } catch (e) {
        emit(PostErrorState('Failed to fetch post details'));
      }
    });

    on<CreatePostEvent>((event, emit) async {
      emit(PostCreatingState());
      try {
        await postRepository.createPost(event.title, event.body);
        emit(PostCreationSuccessState());
      } catch (e) {
        emit(PostErrorState('Failed to create post'));
      }
    });

    // Event handler for updating a post
    on<UpdatePostEvent>((event, emit) async {
      emit(PostEditingState()); 
      try {
        await postRepository.updatePost(event.postId, event.title, event.body);
        emit(PostEditSuccessState()); 
      } catch (e) {
        emit(PostErrorState('Failed to update post'));
      }
    });

   
  }
}

