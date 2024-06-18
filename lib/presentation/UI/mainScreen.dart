// import 'package:flutter/material.dart';
// import 'package:remote/remote.dart';
// import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
// import 'package:todoapp/bloc/auth_bloc/auth_event.dart';

// import 'package:todoapp/hive/database.dart';
// import 'package:todoapp/model/todoModel/note_model.dart';
// import 'package:todoapp/presentation/UI/landing_screen/landing_screen.dart';
// import 'package:todoapp/presentation/widgets/itemContainer.dart';

// import '../Theme/Apptheme_provider.dart';
// import '../widgets/addButton.dart';

// class HomeScreen extends StatelessWidget {
//   String userToken;
//   HomeScreen({
//     Key? key,
//     required this.userToken,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text(userToken),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       final auth = Provider.of<Database>(context, listen: false);
//       auth.getItem();
//     });
//   }

//   final editTitleController = TextEditingController();
//   final editMainController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final remote = Provider.of<Database>(context);

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: InkWell(
//           onTap: () {
//             context.read<AuthBloc>().add(AuthLoggedOut());
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => const LandingScreen()));
//           },
//           child: const Text(
//             'Notes',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () => Provider.of<ThemeProvider>(context, listen: false)
//                 .changeCurrentTheme(),
//             icon: const Icon(Icons.ac_unit_sharp),
//           ),
//         ],
//       ),
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           ListView.builder(
//             itemCount: remote.notes.length,
//             itemBuilder: (context, index) {
//               NoteModel data = remote.notes[index];
//               return ItemContainer(
//                 label: data.title,
//                 mainText: data.mainText,
//                 onDeleted: () => remote.deleteItem(index),
//                 onEdit: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       editMainController.text = data.mainText;
//                       editTitleController.text = data.title;

//                       return AlertDialog(
//                         title: const Text('Edit your note'),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             TextField(
//                               controller: editTitleController,
//                               decoration: const InputDecoration(
//                                 labelText: 'Title',
//                               ),
//                             ),
//                             TextField(
//                               controller: editMainController,
//                               decoration: const InputDecoration(
//                                 labelText: 'Main text',
//                               ),
//                             ),
//                           ],
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('Cancel'),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               remote.updateItem(
//                                 index,
//                                 NoteModel(
//                                     title: editTitleController.text,
//                                     mainText: editMainController.text),
//                               );

//                               remote.getItem();
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('Save'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//           AddButton(context),
//         ],
//       ),
//     );
//   }
// }
