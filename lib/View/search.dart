import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/utils/data.dart';
import 'package:mentor_mentee_connecting/widgets/chat_item.dart';
import 'package:mentor_mentee_connecting/widgets/custom_textfield.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(children: [
        getHeader(),
        getChats(),
      ]),
    );
  }

  getHeader() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 48, 0, 4),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Search Course",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
            SizedBox(height: 12),
            CustomTextBox(
              hint: "Search",
              prefix: Icon(Icons.search, color: Colors.grey),
            ),
          ],
        ));
  }

  getChats() {
    return ListView(
        padding: EdgeInsets.only(top: 10),
        shrinkWrap: true,
        children: List.generate(
            chats.length,
            (index) => ChatItem(
                  chats[index],
                  onTap: () {},
                )));
  }
}
