import 'package:chartapp/api/notifiers/msg/msg_notifier.dart';
import 'package:chartapp/components/models/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MessageApi {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  //
  //
  // function to send a message
  sendMessage(MessageModel msg, String uid) async {
    //assigns current time
    msg.sendTime = Timestamp.now();
    // MessageModel messageModel = MessageModel();

    List<MessageModel> messageList = [];
    var msgList = await messages.doc(uid).set(msg.toMap());

    await messages.doc(uid).set(msg.toMap());
  }

  //
  FirebaseFirestore sRef = FirebaseFirestore.instance;

  // funrction to retrieve a message
  retrieveMessage(MsgNotifier msg, String uid) async {
    QuerySnapshot<Map<String, dynamic>> snap = (await sRef
        .collection('messages')
        .doc(uid)
        .get()) as QuerySnapshot<Map<String, dynamic>>;

    List<MessageModel> msgList = [];

    // for (var doc in snap.docs) {
    //   MessageModel msgRef = MessageModel.fromMap(doc.data());
    //   msgList.add(msgRef);
    // }
    // msg.msgList = msgList;
  }

  //

  // function to delete a message selected by the user
  deleteMessage(String msgId) {}

  //
}
