part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.status = BlocStatus.initial,
    this.forceLogin = false,
  });

  final BlocStatus status;
  final bool forceLogin;

  @override
  List<Object?> get props => [
        status,
        forceLogin,
      ];

  AppState copyWith({
    BlocStatus? status,
    bool? forceLogin,
  }) {
    return AppState(
      status: status ?? this.status,
      forceLogin: forceLogin ?? this.forceLogin,
    );
  }
}
