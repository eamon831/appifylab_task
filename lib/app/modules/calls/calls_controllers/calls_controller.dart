import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/base/base_controller.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CallsController extends BaseController {
  String _scanBarcode = 'Unknown';
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> scanBarcode(BuildContext context) async {
    toast('Under Development');
  }

  Future<void> scanBluetooth(BuildContext context) async {
    toast('Under Development');
  }
}
