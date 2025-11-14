
import 'package:flutter/material.dart';
import 'package:imio_flutter/ui/viewmodels/contact_vm.dart';
import 'package:imio_flutter/utils/size_fit.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, required this.viewModel});
  final ContactViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _ContactPageStats();

}

class _ContactPageStats extends State<ContactPage> {

  ContactViewModel? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel as ContactViewModel;
    viewModel!.test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }),
          actions: <Widget>[
            PopupMenuButton(
              offset: Offset(-20, 30),
              onSelected: (String result) {
                // 处理选中项
                switch (result) {
                  case 'option1':
                    print('选择了选项1');
                    break;
                  case 'option2':
                    print('选择了选项2');
                    break;
                  case 'logout':
                    print('退出登录');
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'option1',
                  child: Text('选项1'),
                ),
                PopupMenuItem(
                  value: 'option2',
                  child: Text('选项2'),
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Text('退出登录'),
                ),
              ],
              icon: Icon(Icons.more_vert), // 自定义图标（可选）
            )
          ],
          title: Text("Contact")
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text("123"),
          )
        ],
      ),
    );
  }


}