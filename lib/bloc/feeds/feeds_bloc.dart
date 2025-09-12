import 'package:bloc/bloc.dart';
import 'package:insta_news/bloc/models/FeedsModel.dart';
import 'package:insta_news/services/api_services.dart';
import 'package:meta/meta.dart';

part 'feeds_event.dart';
part 'feeds_state.dart';

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  FeedsBloc() : super(FeedsInitial()) {
    on<FetchFeeds>((event, emit) async {
      emit(LoadingState());

      try {
        final data = await ApiServices().fetchFeeds();

        final feeds = FeedsModel.fromJson(data);

        emit(LoadedState(feeds));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
