import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../product.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;
  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final List<bool> _isExpanded = List.generate(10, (_) => true);
  final List<String> _listTitres = ["Description","Avis","Caractéristiques"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: widget.product.id,
                  child: SizedBox(
                    height: 200.0,
                    child: Image.network(widget.product.image)),
                ),
                Text(widget.product.title,style: Theme.of(context).textTheme.titleMedium,),
                ExpansionPanelList(
                  //expandedHeaderPadding: EdgeInsets.all(16.0),
                  children: List<ExpansionPanel>.generate(3, (index) => buildExpansionPanel(index)),
                  expansionCallback: (panelIndex, isExpanded) =>setState(() {
                    _isExpanded[panelIndex] = !_isExpanded[panelIndex];
                  })
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  ExpansionPanel buildExpansionPanel(int index)=> ExpansionPanel(
    isExpanded: _isExpanded[index],
    headerBuilder:(_,b)=> ListTile(title:Text(_listTitres[index])),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.product.description,style: Theme.of(context).textTheme.bodyMedium,),
    ),
    canTapOnHeader: true
  );
}
