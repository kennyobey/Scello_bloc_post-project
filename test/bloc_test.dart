import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scelloo_mobile_dev_task/blocs/post_bloc.dart';
import 'package:scelloo_mobile_dev_task/blocs/post_event.dart';
import 'package:scelloo_mobile_dev_task/blocs/post_state.dart';
import 'package:scelloo_mobile_dev_task/models/post_model.dart';
import 'package:scelloo_mobile_dev_task/repositories/post_repositories.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late PostBloc postBloc;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    postBloc = PostBloc(mockPostRepository);
  });

  tearDown(() {
    postBloc.close();
  });

  group('PostBloc Tests', () {
    test('initial state is PostLoadingState', () {
      expect(postBloc.state, PostLoadingState());
    });

    blocTest<PostBloc, PostState>(
      'emits [PostLoadingState, PostLoadedState] when FetchPostsEvent is added',
      build: () {
        when(mockPostRepository.fetchPosts()).thenAnswer(
          (_) async =>
              [Post(id: 1, title: 'Test Post', body: 'Test Body', userId: 1)],
        );
        return postBloc;
      },
      act: (bloc) => bloc.add(FetchPostsEvent()),
      expect: () => [
        PostLoadingState(),
        PostLoadedState(
            [Post(id: 1, title: 'Test Post', body: 'Test Body', userId: 1)]),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostLoadingState, PostErrorState] when FetchPostsEvent fails',
      build: () {
        when(mockPostRepository.fetchPosts())
            .thenThrow(Exception('Failed to fetch posts'));
        return postBloc;
      },
      act: (bloc) => bloc.add(FetchPostsEvent()),
      expect: () => [
        PostLoadingState(),
        PostErrorState('Failed to fetch posts'),
      ],
    );
  });
}
