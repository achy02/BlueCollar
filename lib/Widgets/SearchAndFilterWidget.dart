// import 'package:flutter/material.dart';

// class SearchAndFilterWidget extends StatefulWidget {
//   final String searchText;
//   final ValueSetter<String> onSearchTextChanged;
//   final bool isFullTimeSelected;
//   final ValueSetter<bool?> onFullTimeSelected;
//   final bool isPartTimeSelected;
//   final ValueSetter<bool?> onPartTimeSelected;
//   final bool isRemoteSelected;
//   final ValueSetter<bool?> onRemoteSelected;
//   final String locationText;
//   final ValueSetter<String> onLocationTextChanged;

//   SearchAndFilterWidget({
//     required this.searchText,
//     required this.onSearchTextChanged,
//     required this.isFullTimeSelected,
//     required this.onFullTimeSelected,
//     required this.isPartTimeSelected,
//     required this.onPartTimeSelected,
//     required this.isRemoteSelected,
//     required this.onRemoteSelected,
//     required this.locationText,
//     required this.onLocationTextChanged,
//     required bool locationEnabled,
//     required Null Function() onLocationPressed,
//   });

//   @override
//   _SearchAndFilterWidgetState createState() => _SearchAndFilterWidgetState();
// }

// class _SearchAndFilterWidgetState extends State<SearchAndFilterWidget> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(8),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: 'Search jobs',
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: widget.onSearchTextChanged,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isExpanded = !isExpanded;
//                   });
//                 },
//                 icon: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                           width: 1.0, color: Color.fromARGB(255, 36, 36, 36))),
//                   height: 60,
//                   width: 60,
//                   child: Icon(
//                     Icons.filter_list,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (isExpanded)
//             Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Type',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     CheckboxListTile(
//                       title: Text('Full-time'),
//                       value: widget.isFullTimeSelected,
//                       onChanged: widget.onFullTimeSelected,
//                     ),
//                     CheckboxListTile(
//                       title: Text('Part-time'),
//                       value: widget.isPartTimeSelected,
//                       onChanged: widget.onPartTimeSelected,
//                     ),
//                     CheckboxListTile(
//                       title: Text('Female'),
//                       value: widget.isRemoteSelected,
//                       onChanged: widget.onRemoteSelected,
//                     ),
//                     CheckboxListTile(
//                       title: Text('Male'),
//                       value: widget.isRemoteSelected,
//                       onChanged: widget.onRemoteSelected,
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Location',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8),
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Enter location',
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: widget.onLocationTextChanged,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
