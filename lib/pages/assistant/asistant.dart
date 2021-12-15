import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/model/assistant/chat_message.dart';
import 'package:blood_donation/pages/assistant/components/chat_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/message.dart';

class Assistant extends StatefulWidget {
  const Assistant({Key? key}) : super(key: key);

  @override
  State<Assistant> createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _messagesStream;
  List<ChatMessage> chats = <ChatMessage>[];

  @override
  void initState() {
    super.initState();
    _messagesStream = messagesStream;
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
                  if(chats.isEmpty){
                    return const Center(child: Text("No messages yet"));
                  }
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: MySizes.defaultSpace / 2,
                    ),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return Message(chat: chats[index]);
                    },
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

  Stream<QuerySnapshot<Map<String, dynamic>>> get messagesStream =>
      FirebaseFirestore.instance
          .collection("assistant")
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
