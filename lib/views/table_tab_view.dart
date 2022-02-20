import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_network/controllers/primary_tab_state_controller.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/views/search_input_area.dart';

class TableTabView extends StatefulWidget {
  const TableTabView({Key? key}) : super(key: key);

  @override
  State<TableTabView> createState() => _TableTabViewState();
}

class _TableTabViewState extends State<TableTabView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(vsync: this, length: 3);
    tabController.addListener(() {
      if (tabController.previousIndex != tabController.index) {
        serviceLocator<PrimaryTabController>().changeSelectedPrimaryTabType = tabController.index;
        serviceLocator<PrimaryTabController>().resetSecondaryTabType(tabController.index);
      }
    });
    return Consumer(builder: (
      BuildContext context,
      PrimaryTabController primaryTabController,
      Widget? child,
    ) {
      return Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            controller: tabController,
            tabs: const [
              PrimaryTab(text: 'All'),
              PrimaryTab(text: 'Spot'),
              PrimaryTab(text: 'Futures'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SearchInputArea(),
                SearchInputArea(),
                SearchInputArea(),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class PrimaryTab extends StatelessWidget {
  const PrimaryTab({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 24, width: 80, child: Center(child: Text(text)));
  }
}
