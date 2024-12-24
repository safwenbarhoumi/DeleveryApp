import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_list_tracking.dart';
import 'data_model.dart';

class Timeline2Page extends StatefulWidget {
  const Timeline2Page({
    Key? key,
  }) : super(key: key);

  @override
  State<Timeline2Page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Timeline2Page> {
  List<DataModel> listExample = [];

  @override
  void initState() {
    listExample.add(DataModel(
        title: "En stock",
        desc: "Le colis est actuellement en stock.",
        dateTime: DateTime(2022, 08, 10)));

    listExample.add(DataModel(
        title: "En livraison",
        desc: "Le colis est en cours de livraison.",
        dateTime: DateTime(2022, 08, 12)));

    listExample.add(DataModel(
        title: "Retour",
        desc: "Le colis est retourné au fournisseur.",
        dateTime: DateTime(2022, 08, 23)));

    listExample.add(DataModel(
        title: "Dernière étape",
        desc: "Le colis est retourné au fournisseur.",
        dateTime: DateTime(2022, 08, 23)));

    super.initState();
  }

  String _dateFormat(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Suivi de colis",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: CustomListTracking<DataModel>(
          listItem: listExample,
          valueTextOfTitle: (e) => e.title!,
          valueTextOfDesc: (e) => e.desc!,
          colorCircleTimeline: (e) => e.title == "En livraison"
              ? Colors.yellow
              : e.title == "Retour"
                  ? Colors.red
                  : Colors.blue,
          showLeftWidget: true,
          customLeftWidget: (e) => Column(
            children: [
              Text(
                _dateFormat(e.dateTime!),
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                e.title!,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          valueOfLeftSource: (e) => _dateFormat(e.dateTime!),
        ),
      ),
    );
  }
}
