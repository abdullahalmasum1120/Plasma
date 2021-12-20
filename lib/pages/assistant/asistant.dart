import 'dart:async';

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/model/assistant/chat_message.dart';
import 'package:blood_donation/pages/assistant/components/chat_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'components/message.dart';

class Assistant extends StatefulWidget {
  const Assistant({Key? key}) : super(key: key);

  @override
  State<Assistant> createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _messagesStream;
  final RefreshController _refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();
  int limit = 20;
  List<ChatMessage> chats = <ChatMessage>[];

  @override
  void initState() {
    super.initState();
    _messagesStream = getMessagesStream(limit);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.primary),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: MyColors.white,
        title: Text(
          "Assistant",
          style: MyTextStyles(MyColors.primary).titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading Data"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primary,
                      ),
                    );
                  }
                  chats = fetchChats(snapshot.data!.docs);
                  if (chats.isEmpty) {
                    return const Center(child: Text("No messages yet"));
                  }
                  return SmartRefresher(
                    enablePullUp: true,
                    enablePullDown: false,
                    onLoading: () {
                      setState(() {
                        _messagesStream = getMessagesStream(limit += 20);
                      });
                      _refreshController.loadComplete();
                    },
                    controller: _refreshController,
                    child: ListView.builder(
                      key: const PageStorageKey<String>("scrollKey"),
                      controller: scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: MySizes.defaultSpace / 2,
                      ),
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return Message(chat: chats[index]);
                      },
                    ),
                  );
                }),
          ),
          const Padding(
            padding: EdgeInsets.all(MySizes.defaultSpace / 4),
            child: ChatInputField(),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesStream(int limit) =>
      FirebaseFirestore.instance
          .collection("assistant")
          .limit(limit)
          .orderBy("timeStamp", descending: true)
          .snapshots();

  List<ChatMessage> fetchChats(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    List<ChatMessage> tempChats = <ChatMessage>[];
    for (var element in docs) {
      tempChats.add(ChatMessage.fromJson(element.data()));
    }
    return tempChats;
  }
}
