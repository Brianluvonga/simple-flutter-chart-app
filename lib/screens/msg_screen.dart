import 'package:chartapp/api/notifiers/user_notifier.dart';
import 'package:chartapp/api/user_api.dart';
import 'package:chartapp/components/models/msg_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chartapp/api/message_api.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textField = TextEditingController();

  void clearText() {
    textField.clear();
  }

  MessageModel message = MessageModel();
  MessageApi apiRequest = MessageApi();
  // funtion to initiate sending message
  sendMsg() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();

      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      initializeCurrentUser(authNotifier);

      await apiRequest.sendMessage(message, authNotifier.user!.uid);
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1,
        shadowColor: Colors.white,
        title: const Text(
          'Message Screen',
          style: TextStyle(fontFamily: 'times', fontSize: 14),
        ),
        centerTitle: true,
        actions: [],
        // actions: const [
        //   Icon(Icons.more_vert_sharp),
        // ],
      ),
      body: Stack(
        children: [],
      ),
      floatingActionButton: msgWindow(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget msgWindow() {
    return Container(
      width: 370,
      height: 60,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: TextFormField(
            cursorColor: Colors.black,
            cursorHeight: 20,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                color: Colors.black,
                icon: const Icon(
                  Icons.send_sharp,
                ),
                onPressed: () {
                  sendMsg();
                },
              ),
              prefixIcon: const Icon(
                Icons.attach_file,
                color: Colors.black,
              ),
            ),
            onSaved: (String? value) {
              message.message = value;
            },
            controller: textField,
          ),
        ),
      ),
    );
  }
}
