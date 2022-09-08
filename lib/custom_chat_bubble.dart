import 'package:chat_demo_using_socket/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBubble extends StatefulWidget {
  var isSend;
  String ? textMessage;
  String ? messageTime;
  var imagePath;


  ChatBubble({this.isSend, this.textMessage, this.messageTime,this.imagePath});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {



  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            mainAxisAlignment: widget.isSend==true?MainAxisAlignment.end:MainAxisAlignment.start,
            children: [
              widget.isSend==false?Container(margin: EdgeInsets.only(left: 10),child: CircleAvatar(backgroundImage: AssetImage(widget.imagePath),)):SizedBox(),
              Container(
                padding: const EdgeInsets.all(5),
                margin:  EdgeInsets.only(right: widget.isSend == true ?15:0, top: 25,left:widget.isSend == true ?0:10),
                height: 65,
                width: widget.isSend == true ? Get.width/1.227 : Get.width/1.4279,
                decoration: BoxDecoration(
                    color: widget.isSend == true ? Appcolors.light_blue : Appcolors.grey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                      topLeft: widget.isSend == true ? const Radius.circular(10) : const Radius.circular(0),
                      topRight: widget.isSend == true ? const Radius.circular(0) : const Radius.circular(10),
                    )),
                child: Column(
                    children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
                        child:  Text(
                          widget.textMessage!,
                          style:  TextStyle(fontSize: 15),
                        )),
                  ),
                  const Spacer(),
                  widget.isSend==true?Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.done_all,
                        color: Appcolors.blue_tick_color,
                        size: 20,
                      )):SizedBox()
                ]),
              ),

            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin:  widget.isSend==true?EdgeInsets.only(right: 25):EdgeInsets.only(right: Get.width/5),
                child: Text(
                  widget.messageTime!,
                  style: TextStyle(color: Appcolors.text_color, fontSize: 13),
                ),
              )),
        ]);
  }
}
