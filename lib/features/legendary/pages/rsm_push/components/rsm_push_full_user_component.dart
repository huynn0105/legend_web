import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';

import '../../../../../models/collaborator/collaborator_rsm_push_model.dart';
import '../../../cubit/rsm_push/rsm_push_user_cubit.dart';
import '../items/rsm_push_user_item.dart';

class RSMPushFullUserComponent extends StatelessWidget {
  const RSMPushFullUserComponent({super.key, this.onDelete});

  final Function(CollaboratorRsmPushModel?)? onDelete;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RSMPushUserCubit, RSMPushUserState>(
      builder: (context, state) {
        final List<CollaboratorRsmPushModel> displayUser = List.from(state.users);
        displayUser.addAll(state.addedUsers);
        displayUser.removeWhere((element) => state.removedUsers.contains(element));
        return Container(
          height: 550,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13),
              Text(
                'Danh sách ${state.total} CTV đã chọn',
                style: UITextStyle.medium.copyWith(
                  color: UIColors.grayText,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 60 / 86,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    return RSMPushUserItem(
                        item: displayUser[index],
                        onDelete: () {
                          onDelete?.call(displayUser[index]);
                        }
                    );
                  },
                  itemCount: displayUser.length,
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                width: double.infinity,
                title: 'Quay lại',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 42),
            ],
          ),
        );
      },
    );
  }
}
