import 'package:chat_app/app/components/loading_indicator.dart';
import 'package:chat_app/app/page/home/home_controller.dart';
import 'package:chat_app/app/page/home/widgets/home_app_bar.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5157b2),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            HomeAppBar(
              logout: () => controller.logout(),
              searchController: controller.searchController,
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Obx(
            () => controller.isLoading.value
                ? Center(child: LoadingIndicator())
                : ListView.builder(
                    itemCount: controller.users.value.length,
                    itemBuilder: (context, index) {
                      var user = controller.users.value[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.MESSAGE, arguments: user);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(user.email),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
