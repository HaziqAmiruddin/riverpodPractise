import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:river_pod_practise/features/post/domain/entities/post.dart';
import 'package:river_pod_practise/features/post/presentation/riverpod/post_list_riverpod.dart';

class PostListPage extends ConsumerStatefulWidget {
  const PostListPage({super.key});

  @override
  ConsumerState<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends ConsumerState<PostListPage> {
  final scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels >=
          scrollCtrl.position.maxScrollExtent - 200) {
        ref.read(postListProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(postListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Posts"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final titleController = TextEditingController();
          final bodyController = TextEditingController();

          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("New Post"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                  TextField(
                    controller: bodyController,
                    decoration: const InputDecoration(labelText: "Body"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "title": titleController.text,
                      "body": bodyController.text,
                    });
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );

          if (result != null &&
              result["title"]!.isNotEmpty &&
              result["body"]!.isNotEmpty) {
            ref
                .read(postListProvider.notifier)
                .addPost(result["title"]!, result["body"]!);
          }
        },
      ),

      body: postsAsync.when(
        data: (posts) => RefreshIndicator(
          onRefresh: () => ref.read(postListProvider.notifier).refresh(),
          child: ListView.builder(
            controller: scrollCtrl,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return ListTile(
                leading: CircleAvatar(
                  child: Text("${index + 1}"), // show userId
                ),
                title: Text(post.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.body),
                    const SizedBox(height: 4),
                    Text("Post ID: ${post.id}"), // show post id
                    // Text("Post number: ${index + 1}"), // show number in list
                    Text("Post userID: ${post.userId.toString()}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final titleController = TextEditingController(
                          text: post.title,
                        );
                        final bodyController = TextEditingController(
                          text: post.body,
                        );

                        final updated = await showDialog<Post>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Edit Post"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    labelText: "Title",
                                  ),
                                ),
                                TextField(
                                  controller: bodyController,
                                  decoration: const InputDecoration(
                                    labelText: "Body",
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    post.copyWith(
                                      title: titleController.text,
                                      body: bodyController.text,
                                    ),
                                  );
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          ),
                        );

                        if (updated != null) {
                          ref
                              .read(postListProvider.notifier)
                              .updatePost(updated);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          ref.read(postListProvider.notifier).deletePost(post),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
