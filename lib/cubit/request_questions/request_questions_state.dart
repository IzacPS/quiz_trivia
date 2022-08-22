part of 'request_questions_cubit.dart';

enum RequestQuestionsStatus { initial, loading, success, failure, startgame }

extension RequestQuestionsStatusX on RequestQuestionsStatus {
  bool get isInitial => this == RequestQuestionsStatus.initial;
  bool get isLoading => this == RequestQuestionsStatus.loading;
  bool get isSuccess => this == RequestQuestionsStatus.success;
  bool get isFailure => this == RequestQuestionsStatus.failure;
  bool get isStartGame => this == RequestQuestionsStatus.startgame;
}

class RequestQuestionsState extends Equatable {
  final RequestQuestionsStatus status;
  const RequestQuestionsState({this.status = RequestQuestionsStatus.initial});

  RequestQuestionsState copyWith({RequestQuestionsStatus? status}) {
    return RequestQuestionsState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
