// creating a simple message model to handle data

//
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  String? message;
  Timestamp? sendTime;

  MessageModel();

  MessageModel.fromMap(Map<Map, dynamic> data) {
    id = data['id'];
    message = data['message'];
    sendTime = data['sendTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'sendTime': sendTime,
    };
  }
}
