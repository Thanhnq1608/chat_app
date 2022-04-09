import 'package:chat_app/app/components/loading_indicator.dart';
import 'package:chat_app/app/page/home/home_controller.dart';
import 'package:chat_app/app/page/home/widgets/home_item_list_widget.dart';
import 'package:chat_app/app/page/home/widgets/search_bar_widget.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5157b2),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                _header(context),
                Expanded(
                  child: _recentContact(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 160,
                left: 30,
                right: 30,
              ),
              child: _searchBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      color: Color(0xFF5157b2),
      padding: const EdgeInsets.only(top: kToolbarHeight + 20, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              children: [
                InkWell(
                  onTap: () async {
                    await controller.chooseFile();
                    if (controller.image != null) {
                      await controller.uploadAvatar(
                          imageFile: controller.image!);
                    }
                  },
                  child: controller.currentUser.value.avatar == null
                      ? Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            // shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/avatar_default_icon.png')),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        )
                      : controller.isLoadingAvatar.value
                          ? Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/image_loading.gif')),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            )
                          : Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: ClipOval(
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      controller.currentUser.value.avatar!),
                                  placeholder: AssetImage(
                                      'assets/images/image_loading.gif'),
                                ),
                              ),
                            ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    controller.currentUser.value.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await controller.logout();
                  },
                  icon: Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Column(
      children: [
        SearchBarWidget(
          controller: controller.searchController,
          hintText: 'Search by name',
        ),
        Obx(
          () => controller.usersSearch.value.length == 0
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black87)),
                  child: controller.isLoading.value
                      ? Center(child: LoadingIndicator())
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: controller.usersSearch.value.length,
                          itemBuilder: (context, index) {
                            var user = controller.usersSearch.value[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.MESSAGE, arguments: user);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                  ),
                                  Text(user.email),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
        ),
      ],
    );
  }

  Widget _recentContact() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Obx(() => controller.isLoading.value
          ? Center(
              child: LoadingIndicator(),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                var recentContact = controller.recentContacts[index];
                var senderName = recentContact.sender
                            .compareTo(controller.currentUser.value.email) !=
                        0
                    ? recentContact.name
                    : 'You';
                return InkWell(
                  onTap: () async {
                    var user =
                        await controller.getUser(email: recentContact.email);
                    var result =
                        await Get.toNamed(AppRoutes.MESSAGE, arguments: user);
                    await controller.seenMessage(contact: result);
                  },
                  child: HomeItemListWidget(
                    recentContact: recentContact,
                    senderName: senderName,
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: Colors.black87,
                    height: 2,
                  )),
              itemCount: controller.recentContacts.value.length)),
    );
  }
}
