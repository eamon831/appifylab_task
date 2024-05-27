import 'package:get/get.dart';

import '/app/modules/chat_with_user/bindings/chat_with_user_binding.dart';
import '/app/modules/chat_with_user/view/chat_with_user_view.dart';
import '/app/modules/chats/bindings/chats_binding.dart';
import '/app/modules/chats/views/chats_view.dart';
import '/app/modules/login/bindings/login_binding.dart';
import '/app/modules/login/views/login_view.dart';
import '/app/modules/main/bindings/main_binding.dart';
import '/app/modules/main/views/main_view.dart';
import '/app/modules/register/bindings/register_binding.dart';
import '/app/modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CHATS,
      page: () => ChatsView(),
      binding: ChatsBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_WITH_USER,
      page: () => ChatWithUserView(),
      binding: ChatWithUserBinding(),
    )
  ];
}
