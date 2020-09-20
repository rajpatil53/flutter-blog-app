part of 'post_bloc.dart';

@immutable
abstract class PostState {
  int get tabIndex => 0;
}

// class PostInitial extends PostState {}

class FetchingPosts extends PostState {
  int get tabIndex => 0;
}

class PostsFetched extends PostState {
  final List<Post> posts;
  final int currentTabIndex;
  final User user;

  List<Post> get filteredPosts {
    switch (currentTabIndex) {
      case 0:
        return posts;
      case 1:
        return posts.where((post) => post.userId == user.id).toList();
      case 2:
        return posts
            .where((post) => user.likedPosts.contains(post.id))
            .toList();
      default:
        return [];
    }
  }

  int get tabIndex => currentTabIndex;

  PostsFetched({this.posts, this.currentTabIndex, this.user});
}
