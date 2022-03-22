import 'package:chat_app/app/page/home/widgets/recent_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  final Function() logout;
  final TextEditingController searchController;
  HomeAppBar({Key? key, required this.logout, required this.searchController})
      : super(key: key);

  final double maxHeight = 80;
  final double minHeight = 200;

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);

    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;

    return expandRatio;
  }

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context);
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: Color(0xFF5157b2),
      pinned: true,
      flexibleSpace: SafeArea(
        bottom: true,
        child: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            final expandRatio = _calculateExpandRatio(constraints);
            final animation = AlwaysStoppedAnimation(expandRatio);
            RxDouble top = constraints.biggest.height.obs;
            return FlexibleSpaceBar(
              centerTitle: true,
              title: Obx(() => _appbarUp(context, top)),
              background: _appbarDefault(context),
              stretchModes: const [
                StretchMode.fadeTitle,
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _appbarUp(BuildContext context, RxDouble top) {
    return top.value == MediaQuery.of(context).padding.top + kToolbarHeight
        ? Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Chat with your friends',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await logout();
                  },
                  icon: Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _appbarDefault(BuildContext context) {
    return Container(
      color: Color(0xFF5157b2),
      padding: const EdgeInsets.only(top: kToolbarHeight - 20, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Chat with \nyour friends',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await logout();
                },
                icon: Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          RecentContacts(searchController: searchController),
        ],
      ),
    );
  }
}
