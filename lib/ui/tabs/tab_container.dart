import 'package:flutter/material.dart';
import 'package:news_app/ui/tabs/tab_item.dart';
import '../../models/SourceResponse.dart';
import '../news/news_container.dart';

class TabContainer extends StatefulWidget {
  List<Sources> sourcesList;
  TabContainer({required this.sourcesList});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
              padding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              labelColor: Colors.transparent,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                tabs: widget.sourcesList
                    .map((source) => TabItem(
                        source: source,
                        isSelected: selectedIndex ==
                            widget.sourcesList.indexOf(source)))
                    .toList()),
            Expanded(child: NewsContainer(sources: widget.sourcesList[selectedIndex]))
          ],
        ));
  }
}
