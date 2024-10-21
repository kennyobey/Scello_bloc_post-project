import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/post_bloc.dart';
import 'blocs/post_event.dart';
import 'repositories/post_repositories.dart';
import 'screens/create_post.dart';
import 'screens/edit_post_screen.dart';
import 'screens/post_deatils_screen.dart';
import 'screens/post_list_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts App',
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) =>
                  PostBloc(postRepository)..add(FetchPostsEvent()),
              child: const PostListScreen(),
            ),
        '/createPost': (context) => BlocProvider(
              create: (context) => PostBloc(postRepository),
              child: const CreatePostScreen(),
            ),
        '/postDetail': (context) {
          final postId = ModalRoute.of(context)!.settings.arguments as int;
          return BlocProvider(
            create: (context) =>
                PostBloc(postRepository)..add(FetchPostDetailEvent(postId)),
            child: PostDetailScreen(postId: postId),
          );
        },
        '/editPost': (context) {
          final postId = ModalRoute.of(context)!.settings.arguments as int;
          return BlocProvider(
            create: (context) => PostBloc(postRepository), // Provide the PostBloc here
            child: EditPostScreen(postId: postId, initialTitle: '', initialBody: '',), // Pass postId to EditPostScreen
          );
        },
      },
    );
  }
}
