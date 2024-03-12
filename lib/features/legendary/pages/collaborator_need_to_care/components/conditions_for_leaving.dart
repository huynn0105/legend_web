part of '../collaborator_need_to_care_page.dart';

class _ConditionsForLeaving extends StatelessWidget {
  const _ConditionsForLeaving();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Cộng tác viên của bạn có thể rời đi khi thỏa 1 trong 3 điều kiện dưới đây:',
            style: UITextStyle.regular,
          ),
          const SizedBox(height: 12),
          _LeaveItem(
            title: 'Điều kiện 1',
            image: 'ic_income',
            content: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: '30 ngày ',
                  ),
                  TextSpan(
                    text: 'không ',
                    style: UITextStyle.medium.copyWith(
                      color: UIColors.red,
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: 'phát sinh thu nhập',
                  ),
                ],
                style: UITextStyle.medium.copyWith(
                  color: UIColors.blurBackground,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: UIColors.background,
          ),
          _LeaveItem(
            title: 'Điều kiện 2',
            image: 'ic_work',
            content: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: '15 ngày ',
                  ),
                  TextSpan(
                    text: 'không ',
                    style: UITextStyle.medium.copyWith(
                      color: UIColors.red,
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: 'có hoạt động làm việc trên MFast ',
                  ),
                  TextSpan(
                    text: 'và không ',
                    style: UITextStyle.medium.copyWith(
                      color: UIColors.red,
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: 'phát sinh thu nhập ',
                  ),
                ],
                style: UITextStyle.medium.copyWith(
                  color: UIColors.blurBackground,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: UIColors.background,
          ),
          _LeaveItem(
            title: 'Điều kiện 3',
            image: 'ic_leave',
            content: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: '10 ngày ',
                  ),
                  TextSpan(
                    text: 'không ',
                    style: UITextStyle.medium.copyWith(
                      color: UIColors.red,
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: 'mở MFast ',
                  ),
                  TextSpan(
                    text: 'và không ',
                    style: UITextStyle.medium.copyWith(
                      color: UIColors.red,
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: 'phát sinh thu nhập',
                  ),
                ],
                style: UITextStyle.medium.copyWith(
                  color: UIColors.blurBackground,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppSplashButton(
            onTap: () {
              GlobalFunction.pushWebView(url: AppConstants.collaboratorLeaveDetailUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Xem chi tiết điều kiện tại đây',
                    style: UITextStyle.medium.copyWith(
                      color: UIColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LeaveItem extends StatelessWidget {
  const _LeaveItem({
    required this.image,
    required this.title,
    required this.content,
  });

  final String image;
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: UIColors.white,
              ),
              child: AppImage.asset(asset: image)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: UITextStyle.regular.copyWith(
                    color: UIColors.grayBackground,
                  ),
                ),
                content,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
