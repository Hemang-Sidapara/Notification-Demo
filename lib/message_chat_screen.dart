import 'package:chat_demo_using_socket/colors.dart';
import 'package:chat_demo_using_socket/custom_chat_bubble.dart';
import 'package:chat_demo_using_socket/messages_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sails_io/sails_io.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageChatScreen extends StatefulWidget {
  final String? user;

  const MessageChatScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<MessageChatScreen> createState() => _MessageChatScreenState();
}

class _MessageChatScreenState extends State<MessageChatScreen> {
  late TextEditingController textEditingController;
  late ScrollController _controller;
  IO.Socket? socket;
  SailsIOClient? _sailsIOClient;

  void _sendMessage() {
    String messageText = textEditingController.text.trim();
    textEditingController.text = '';
    if (messageText != '') {
      var messagePost = {
        'message': messageText,
        'senderId': 1,
        'receiverId': int.parse(widget.user!),
      };
      _sailsIOClient!.socket.emit('chat', messagePost);
      print("Chat :::: $messageText");
      var data = {};
      _sailsIOClient!.socket.emitWithAck('get', data, ack: (data) {
        print(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _controller = ScrollController();
    initSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          _controller.animateTo(
            0.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          )
        });
  }

  Future<void> initSocket() async {
    // print('Connecting to chat service');
    try {
      _sailsIOClient = SailsIOClient(IO.io(
          "http://192.168.0.175:1401",
          IO.OptionBuilder()
              .setTransports(
                ['websocket'],
              )
              .disableAutoConnect() // disable auto-connection
              .setExtraHeaders({'foo': 'bar'}) // optional
              .build()));
      _sailsIOClient!.socket.onConnect((a) async {
        print('onConnect');
        _sailsIOClient!.post(
          url: "http://192.168.0.175:1401/socket-subscribe",
          data: {
            "id": 2,
          },
          cb: (response, JWR) {
            print('${response.toString()}<<<<===OWNER SUBSCRIBE SUCCESSFULLY===>>>${JWR.toJson()}');
          },
        );
      });
      _sailsIOClient!.socket.onError((data) {
        print('onError === > $data');
      });
      _sailsIOClient!.socket.onDisconnect((_) {
        print('onDisconnect');
      });
      _sailsIOClient!.socket.onConnecting((data) {
        print('onConnecting');
      });
      _sailsIOClient!.socket.onConnectError((data) {
        print('onConnectError ==> $data');
      });
      _sailsIOClient!.socket.on('newChat', (message) {
        print("newChat ::: $message");
        setState(() {
          MessagesModel.messages.add(message);
        });
      });
      _sailsIOClient!.socket.on('allChats', (messages) {
        print("allChats ::: $messages");
        setState(() {
          MessagesModel.messages.addAll(messages);
        });
      });
      _sailsIOClient!.socket.connect();
    } catch (e) {
      print('SOCKET IO CONNECTION ERROR ::::::::: ${e}');
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _sailsIOClient!.socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primary_white,
      appBar: AppBar(
        title: const Text('Chat Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 1.32,
              child: Stack(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          height: 0.7,
                          color: Appcolors.secondary_blue,
                        ),
                      ),
                      Text(
                        'Yesterday',
                        style: TextStyle(fontSize: 14, color: Appcolors.primary_blue),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          height: 0.7,
                          color: Appcolors.secondary_blue,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    cacheExtent: 1000,
                    itemCount: MessagesModel.messages.length,
                    itemBuilder: (context, index) {
                      var message = MessagesModel.messages[MessagesModel.messages.length - index - 1];
                      return (message['sender'] != widget.user)
                          ? ChatBubble(
                              textMessage: message['message'],
                              imagePath: "assets/images/circledp.png",
                              isSend: true,
                              messageTime: message['time'],
                            )
                          : ChatBubble(
                              textMessage: message['message'],
                              imagePath: "assets/images/circledp.png",
                              isSend: false,
                              messageTime: message['time'],
                            );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    width: Get.width / 1.35,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Appcolors.primary_grey),
                    child: TextFormField(
                      controller: textEditingController,
                      onTap: () {},
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Type Here...',
                        suffixIcon: InkWell(
                          onTap: () async {
                            if (textEditingController.text.isEmpty) {
                              return;
                            }
                            _sendMessage();
                          },
                          child: const Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(color: Appcolors.light_blue, borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.wheelchair_pickup),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
