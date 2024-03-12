// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    this.status = BlocStatus.initial,
    this.userInfo,
    this.referral,
    this.userMetaData,
    this.avatarStatus = BlocStatus.initial,
    this.errorMessage,
  });

  final BlocStatus status;
  final UserInfoModel? userInfo;
  final ReferralInfoModel? referral;
  final UserMetaDataModel? userMetaData;
  final BlocStatus avatarStatus;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        userInfo,
        referral,
        userMetaData,
        avatarStatus,
        errorMessage,
      ];

  UserState copyWith({
    BlocStatus? status,
    UserInfoModel? userInfo,
    ReferralInfoModel? referral,
    UserMetaDataModel? userMetaData,
    BlocStatus? avatarStatus,
    String? errorMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      userInfo: userInfo ?? this.userInfo,
      referral: referral ?? this.referral,
      userMetaData: userMetaData ?? this.userMetaData,
      avatarStatus: avatarStatus ?? this.avatarStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
