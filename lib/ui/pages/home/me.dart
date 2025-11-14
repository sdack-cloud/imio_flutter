import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imio_flutter/ui/viewmodels/me_vm.dart';
import 'package:imio_flutter/utils/size_fit.dart';

class MePage extends StatefulWidget {
  const MePage({super.key, required this.viewModel});

  final MeViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  MeViewModel? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel as MeViewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true, // 滚动到顶部后固定
            expandedHeight: 300.rpx, // 展开高度
            snap: false,
            floating: false,
            collapsedHeight:200.rpx, // 缩放高度
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.white,
                tooltip: 'Setting',
                onPressed: () {
                  context.push("/setting");
                },
              ),
            ],
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4), // 阴影向下偏移 4px
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://ossweb-img.qq.com/images/lol/web201310/skin/big10008.jpg",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "nickname",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                      ),
                      Text(
                        "dsd",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            Card(
              margin: EdgeInsets.fromLTRB(10,5,10,5),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: ElevatedButton(onPressed: (){
                  viewModel!.conn();
                }, child: Text("conn")),
              )
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10,5,10,5),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: ElevatedButton(onPressed: (){
                  viewModel!.disconn();
                }, child: Text("close")),
              )
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10,5,10,5),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: ElevatedButton(onPressed: (){
                  viewModel!.ping();
                }, child: Text("ping")),
              )
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10,5,10,5),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: ElevatedButton(onPressed: (){}, child: Text("1321")),
              )
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10,5,10,5),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: ElevatedButton(onPressed: (){}, child: Text("1321")),
              )
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10,5,10,5),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: ElevatedButton(onPressed: (){}, child: Text("1321")),
              )
            ),

          ]))
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
