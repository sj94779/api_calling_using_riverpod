import 'package:api_calling_using_riverpod/post.dart';
import 'package:api_calling_using_riverpod/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            PostState state = ref.watch(postsProvider);
            if (state is InitialPostState) {
              return const Text('Press FAB to fetch data');
            }

            if (state is PostsLoadingPostState) {
              return const CircularProgressIndicator();
            }

            if (state is ErrorPostState) {
              return Text(state.message);
            }

            if (state is PostsLoadedPostState) {
              return _buildListView(state);
            }
            return const Text('khgjfhjgv');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postsProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.read_more),
      ),
    );
  }

  Widget _buildListView(PostsLoadedPostState state) {
    return ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          Post post = state.posts[index];
          return ListTile(leading: Text(post.title));
        });
  }
}
