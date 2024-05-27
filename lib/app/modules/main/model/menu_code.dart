import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'menu_item.dart';

enum MenuCode { chats, updates, communities,calls }

extension MenuCodeExtensions on MenuCode {
  BottomNavItem toBottomNavItem(
    AppLocalizations appLocalization,
  ) {
    switch (this) {
      case MenuCode.chats:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavChats,
          iconSvgName: 'ic_chats.svg',
          menuCode: MenuCode.chats,
        );
      case MenuCode.updates:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavUpdates,
          iconSvgName: 'ic_updates.svg',
          menuCode: MenuCode.updates,
        );
      case MenuCode.communities:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavCommunities,
          iconSvgName: 'ic_communities.svg',
          menuCode: MenuCode.communities,
        );
      case MenuCode.calls:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavCalls,
          iconSvgName: 'ic_calls.svg',
          menuCode: MenuCode.calls,
        );
    }
  }
}
