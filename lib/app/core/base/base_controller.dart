import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

import '/app/core/model/page_state.dart';
import '/app/network/exceptions/api_exception.dart';
import '/app/network/exceptions/app_exception.dart';
import '/app/network/exceptions/json_format_exception.dart';
import '/app/network/exceptions/network_exception.dart';
import '/app/network/exceptions/not_found_exception.dart';
import '/app/network/exceptions/service_unavailable_exception.dart';
import '/app/network/exceptions/unauthorize_exception.dart';
import '/flavors/build_config.dart';
import 'mixins/table_mixin.dart';

abstract class BaseController extends GetxController with TableMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final LocalAuthentication localAuth = LocalAuthentication();

  final Logger logger = BuildConfig.instance.config.logger;

  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  final logoutController = false.obs;

  //Reload the page
  final _refreshController = false.obs;

  bool refreshPage(bool refresh) => _refreshController(refresh);

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;

  PageState updatePageState(PageState state) => _pageSateController(state);

  PageState resetPageState() => _pageSateController(PageState.DEFAULT);

  PageState showLoading() => updatePageState(PageState.LOADING);

  PageState hideLoading() => resetPageState();

  final _messageController = ''.obs;

  String get message => _messageController.value;

  String showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  showErrorMessage(String msg) {
    _errorMessageController(msg);
  }

  final _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  String showSuccessMessage(String msg) => _successMessageController(msg);

  // ignore: long-parameter-list
  dynamic callDataService<T>(
    Future<T> future, {
    Function(Exception exception)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
  }) async {
    Exception? _exception;

    onStart == null ? showLoading() : onStart();

    try {
      final T response = await future;

      if (onSuccess != null) onSuccess(response);

      onComplete == null ? hideLoading() : onComplete();

      return response;
    } on ServiceUnavailableException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on UnauthorizedException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on TimeoutException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message ?? 'Timeout exception');
    } on NetworkException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on JsonFormatException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on NotFoundException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on ApiException catch (exception) {
      _exception = exception;
    } on AppException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } catch (error) {
      _exception = AppException(message: "$error");
      logger.e("Controller>>>>>> error $error");
    }

    if (onError != null) onError(_exception);

    onComplete == null ? hideLoading() : onComplete();
  }

  @override
  void onClose() {
    _messageController.close();
    _refreshController.close();
    _pageSateController.close();
    super.onClose();
  }

  Future<bool> authenticate() async {
    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to access your chats',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } else {
      isAuthenticated = true;
    }

    return isAuthenticated;
  }
}
