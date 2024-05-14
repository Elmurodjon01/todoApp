
// ListView.builder(
//      itemCount: model.inventoryList.length,
//      itemBuilder: (context, index) {
//        Inventory inv = model.inventoryList[index];
//        return Container(
//           margin: EdgeInsets.symmetric(
//           vertical: 2.height,
//           horizontal: 4.5.width,
//          ),
//           height: 13.height,
//           decoration: BoxDecoration(
//           color: Colors.white,
//           ),
//           child: Row(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(left: 2.width),
//                 width: 16.width,
//                 decoration: BoxDecoration(
//                 color: Colors.green[600],
//                 shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Icon(
//                      Icons.home,
//                      color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                      padding: EdgeInsets.symmetric(
//                      vertical: 3.height,
//                      horizontal: 3.width,
//                      ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                             Text(
//                              inv.name,
//                               style: TextStyle(
//                                color: Colors.green[600],
//                                fontWeight: FontWeight.w600,
//                                fontSize: 4.5.text,
//                                  ),
//                                ),
//                                SizedBox(
//                                 height: 1.height,
//                                ),
//                                   Text(
//                                     inv.description,
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 4.text,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 8.width),
//                               child: PopupMenuButton(
//                                 onSelected: (item) {
//                                   switch (item) {
//                                     case 'update':
//                                       nameController.text = inv.name;
//                                       descriptionController.text =
//                                           inv.description;

//                                       inputItemDialog(context, 'update', index);
//                                       break;
//                                     case 'delete':
//                                       model.deleteAt(index);
//                                   }
//                                 },
//                                 itemBuilder: (context) {
//                                   return [
//                                     PopupMenuItem(
//                                       value: 'update',
//                                       child: Text('Update'),
//                                     ),
//                                     PopupMenuItem(
//                                       value: 'delete',
//                                       child: Text('Delete'),
//                                     ),
//                                   ];
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   )