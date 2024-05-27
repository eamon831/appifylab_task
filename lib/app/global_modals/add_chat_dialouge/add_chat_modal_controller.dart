import 'package:appifylab_task/app/core/model/page_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '/app/core/base/base_controller.dart';

class AddChatModalController extends BaseController {
  final emailController = TextEditingController();

  Future<void> addChat() async {
    final storage = FirebaseStorage.instanceFor(
      bucket: 'gs://appifylabtask.appspot.com/users',
    );
    final ref = FirebaseDatabase.instance.ref();

    print(storage);

    updatePageState(PageState.LOADING);
    // delay
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        updatePageState(PageState.DEFAULT);
      },
    );
  }
}
