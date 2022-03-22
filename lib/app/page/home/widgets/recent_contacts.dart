import 'package:chat_app/app/page/home/widgets/search_bar_widget.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentContacts extends StatelessWidget {
  final TextEditingController searchController;
  RecentContacts({required this.searchController});
  final contacts = User.generateUsers();
  RxBool isClickToSearch = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              if (isClickToSearch.value) {
                isClickToSearch(false);
              } else {
                isClickToSearch(true);
              }
            },
            child: Icon(
              Icons.search,
              size: 28,
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(50, 50),
                elevation: 0,
                padding: EdgeInsets.zero,
                onPrimary: Colors.white,
                primary: Colors.white.withOpacity(0.3),
                shape: CircleBorder()),
          ),
          SizedBox(
            width: 15,
          ),
          Obx(
            () => Expanded(
              child: isClickToSearch.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: SearchBarWidget(
                        controller: searchController,
                        onClickToIcon: () {},
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var color = contacts[index].userColor;
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.MESSAGE,
                                    arguments: contacts[index]);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: color, shape: BoxShape.circle),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage(contacts[index].avatar),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        );
                      },
                      itemCount: contacts.length),
            ),
          )
        ],
      ),
    );
  }
}
