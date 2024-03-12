import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/legendary_page.dart';

@RoutePage()
class LegendaryHierCollaboratorPage extends StatelessWidget {
  const LegendaryHierCollaboratorPage({
    super.key,
    @QueryParam("userID") this.userID,
  });

  final String? userID;

  @override
  Widget build(BuildContext context) {
    return LegendaryPage(
      userID: userID,
    );
  }
}
