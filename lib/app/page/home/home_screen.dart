import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: Color(0xFF5157b2),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _buildAppBar(context),
          ];
        },
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: Color(0xFF5157b2),
      pinned: true,
      flexibleSpace: SafeArea(
        child: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            final expandRatio = _calculateExpandRatio(constraints);
            final animation = AlwaysStoppedAnimation(expandRatio);
            var top = constraints.biggest.height;
            return FlexibleSpaceBar(
              centerTitle: true,
              title: _appbarUp(context, top),
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

  Widget _appbarUp(BuildContext context, double top) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 30),
      opacity: top == MediaQuery.of(context).padding.top + kToolbarHeight
          ? 1.0
          : 0.0,
      child: Text(
        'Chat with your friends',
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _appbarDefault(BuildContext context) {
    return Container(
      color: Color(0xFF5157b2),
      padding: const EdgeInsets.only(top: kToolbarHeight - 20, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chat with \nyour friends',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
