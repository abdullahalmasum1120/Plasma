import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final BuildContext context;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final TextEditingController controller;
  final IconData suffixIcon;

  const SearchBar({
    Key? key,
    required this.context,
    required this.onChanged,
    required this.onClear,
    required this.controller,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MySizes.defaultRadius),
            ),
            contentPadding: const EdgeInsets.all(MySizes.defaultSpace / 2),
            hintText: "Search donor",
            fillColor: MyColors.primary.withOpacity(0.05),
            filled: true,
            prefixIcon: IconButton(
              onPressed: () {
                //TODO: implements filter
              },
              icon: const Icon(Icons.filter_list),
            ),
            suffixIcon: IconButton(
              onPressed: onClear,
              icon: Icon(
                suffixIcon,
                color: (suffixIcon == Icons.search)
                    ? MyColors.grey
                    : MyColors.primary,
              ),
            ),
          ),
          onChanged: onChanged,
        ),
        // new Visibility(
        //   visible: isVisibleFilters,
        //   child: new Column(
        //     children: [
        //       new Container(
        //         padding:
        //             EdgeInsets.symmetric(vertical: 10),
        //         decoration: new BoxDecoration(
        //           color: Colors.white,
        //           boxShadow: [
        //             new BoxShadow(
        //               color:
        //                   Colors.grey.withOpacity(0.2),
        //               blurRadius: 10,
        //               spreadRadius: 10,
        //             ),
        //           ],
        //         ),
        //         alignment: Alignment.center,
        //         width: double.infinity,
        //         child: new Text(
        //           "Filters",
        //           style: new TextStyle(
        //             fontSize: 20,
        //             letterSpacing: 1.25,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //       new SizedBox(
        //         height: 10,
        //       ),
        //       Container(
        //         width: double.infinity,
        //         height: 300,
        //         child: new SingleChildScrollView(
        //           child: new Column(
        //             children: [
        //               new FilterOptions(
        //                 itemList: [
        //                   "A+",
        //                   "B+",
        //                   "O+",
        //                   "AB+"
        //                 ],
        //                 title: "Blood Type",
        //               ),
        //               new FilterOptions(
        //                 itemList: ["Dhaka", "Cumilla"],
        //                 title: "Location",
        //               ),
        //               new FilterOptions(
        //                 itemList: [
        //                   "BLood bank name",
        //                   "Blood bank name"
        //                 ],
        //                 title: "Blood Bank",
        //               ),
        //               new FilterOptions(
        //                 itemList: ["Name", "Name"],
        //                 title: "Donors",
        //               ),
        //               new SizedBox(
        //                 height: 20,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       new MyFilledButton(
        //         child: new Text(
        //           "Apply",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 20,
        //             letterSpacing: 1.2,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         size: new Size(0, 0),
        //         borderRadius: 50,
        //         function: () {},
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
