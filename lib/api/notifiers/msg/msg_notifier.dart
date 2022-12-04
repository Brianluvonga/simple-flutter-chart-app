import 'dart:collection';

import 'package:chartapp/components/models/msg_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MsgNotifier extends ChangeNotifier {
  List<MessageModel> _msgList = [];
  MessageModel _currentMsg = MessageModel();

  UnmodifiableListView<MessageModel> get msgList =>
      UnmodifiableListView(_msgList);

//get details of current sacco
  MessageModel get currentMsg => _currentMsg;

  set msgList(List<MessageModel> msgList) {
    _msgList = msgList;
    notifyListeners();
  }

  set currentMsg(MessageModel msg) {
    _currentMsg = msg;
    notifyListeners();
  }

  sendMsg(MessageModel msg) {
    _msgList.insert(0, msg);
    notifyListeners();
  }

  deleteSacco(MessageModel msg) {
    _msgList.removeWhere((element) => element.id == msg.id);
  }
}
