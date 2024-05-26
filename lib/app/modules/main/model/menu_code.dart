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
          iconSvgName: 'ic_home.svg',
          menuCode: MenuCode.chats,
        );
      case MenuCode.updates:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavUpdates,
          iconSvgName: 'ic_favorite.svg',
          menuCode: MenuCode.updates,
        );
      case MenuCode.communities:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavCommunities,
          iconSvgName: 'ic_settings.svg',
          menuCode: MenuCode.communities,
        );
      case MenuCode.calls:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavCalls,
          iconSvgName: 'ic_settings.svg',
          menuCode: MenuCode.calls,
        );
    }
  }
}
