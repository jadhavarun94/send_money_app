import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/repository/post_repository.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/post_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/events/post_event.dart';
import 'package:send_money_app_assignment/viewmodels/states/post_state.dart';


class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Posts')),
      body: BlocProvider(
        create: (context) => PostBloc(
          RepositoryProvider.of<PostRepository>(context),
        )..add(FetchPosts()),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
