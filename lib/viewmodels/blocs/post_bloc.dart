import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:send_money_app_assignment/repository/post_repository.dart';
import 'package:send_money_app_assignment/viewmodels/events/post_event.dart';
import 'package:send_money_app_assignment/viewmodels/states/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        // Fetch from API
        final posts = await repository.fetchPostsFromApi();
        emit(PostLoaded(posts));
      } else {
        // Fetch from Local
        final posts = repository.fetchPostsFromLocal();
        if (posts.isNotEmpty) {
          emit(PostLoaded(posts));
        } else {
          emit(PostError('No internet and no local data available.'));
        }
      }
    } catch (e) {
      emit(PostError('Failed to fetch posts: $e'));
    }
  }
}
