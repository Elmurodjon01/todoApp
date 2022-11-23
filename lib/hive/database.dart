// import 'package:hive/hive.dart';
// import 'package:todoapp/model/note_model.dart';

// class HiveDB {
//   var box = Hive.box('Notes');

//   storeUser(NoteModel noteModel) {
//     box.put('noteModel', noteModel.toJson());
//   }

//   NoteModel loadUser() {
//     var noteModel = NoteModel.fromJson(box.get('noteModel'));
//     return noteModel;
//   }

//   deleteUser() {
//     box.delete('noteModel');
//   }

//   // storeAccount(Account account) {
//   //   box.put('account', account.toJson());
//   // }

//   // Account loadAccount() {
//   //   var account = Account.fromJson(box.get('account'));
//   //   return account;
//   // }

//   // deleteAccount() {
//   //   box.delete('account');
//   // }
// }
