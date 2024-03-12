import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';

import '../../../../../models/collaborator/collaborator_rsm_push_model.dart';

class RSMPushRemoveUserComponent extends StatelessWidget {
  const RSMPushRemoveUserComponent({
    super.key,
    this.user,
    this.onRemoveUser,
  });

  final CollaboratorRsmPushModel? user;
  final Function()? onRemoveUser;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: const BoxDecoration(
          color: UIColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            ChatAvatar(
              url: user?.avatarImage ?? '',
              name: user?.fullName ?? '',
              size: 80,
            ),
            const SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: UITextStyle.regular.copyWith(
                  fontSize: 16,
                  color: UIColors.grayText,
                ),
                children: [
                  const TextSpan(
                    text: 'Xác nhận xoá ',
                  ),
                  TextSpan(
                    text: '${user?.fullName} (mã MFast: ${user?.referralCode ?? ''})',
                    style: UITextStyle.semiBold.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: ' ra khỏi danh sách gửi tin nhắn',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: const BoxDecoration(
                color: UIColors.lightBlue,
              ),
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: Row(
                children: [
                  Expanded(
                    child: SplashButton(
                      onTap: () {
                        onRemoveUser?.call();
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Xoá khỏi danh sách',
                          style: UITextStyle.medium.copyWith(
                            color: UIColors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SplashButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Quay lại',
                          style: UITextStyle.medium.copyWith(
                            color: UIColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
