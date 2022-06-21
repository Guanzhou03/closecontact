import 'package:close_contact/models/user_model.dart';

class Message {
  final String senderID;
  final String
  time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    required this.senderID,
    required this.time,
    required this.text,
    required this.unread,
  });
}

// YOU - current user
final User currentUser =
User(id: 0, name: 'Current User', imageUrl: 'assets/images/greg.jpg');

// USERS
final User greg = User(id: 1, name: 'Greg', imageUrl: 'assets/images/greg.jpg');
final User james =
User(id: 2, name: 'James', imageUrl: 'assets/images/james.jpg');
final User john = User(id: 3, name: 'John', imageUrl: 'assets/images/john.jpg');
final User olivia =
User(id: 4, name: 'Olivia', imageUrl: 'assets/images/olivia.jpg');
final User sam = User(id: 5, name: 'Sam', imageUrl: 'assets/images/sam.jpg');
final User sophia =
User(id: 6, name: 'Sophia', imageUrl: 'assets/images/sophia.jpg');
final User steven =
User(id: 7, name: 'Steven', imageUrl: 'assets/images/steven.jpg');

// FAVORITE CONTACTS
List<User> favorites = [sam, steven, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    senderID: 'QLVpECCTMAgPAZr1dw0TuxQsljF3',
    time: '5:30 PM',
    text: 'Text 1',
    unread: true,
  ),
  Message(
    senderID: 'JqD1JCk5MZR5gBMxzYHCd66z6po2',
    time: '4:30 PM',
    text: 'Text 2',
    unread: true,
  ),
  Message(
    senderID: 'jDYEwSEStySyb4DRfBmjGsUnpF63',
    time: '3:30 PM',
    text: 'Text 3',
    unread: false,
  ),
];

