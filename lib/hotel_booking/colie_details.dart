import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../fitness_app/fitness_app_theme.dart';

class HotelDetails extends StatelessWidget {
  final String completeName;
  final int phone;
  final String address;
  final String colieState;
  final String time;
  final String barcode;
  final int amount;
  final String recipientInfo;
  final String supplierInfo;
  final activeColor = Colors.blue[800]!;
  final inactiveColor = Colors.grey[600]!;

  HotelDetails({
    required this.completeName,
    required this.phone,
    required this.address,
    required this.colieState,
    required this.time,
    required this.barcode,
    required this.amount,
    required this.recipientInfo,
    required this.supplierInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set background color of the screen to white
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for AppBar
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Colis details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    letterSpacing: 1.2,
                    color: FitnessAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[gr],
      ),
    );
  }

  get gr => Expanded(
        child: Container(
          color: Colors.white, // Ensure white background for the grid container
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            crossAxisCount: 2,
            childAspectRatio: .9999,
            children: <Widget>[
              buildCard(
                child: buildDetailRow(Icons.qr_code, 'code à barre', barcode),
              ),
              buildCard(
                child: buildClickableDetailRow(
                  Icons.phone,
                  'Telephone',
                  phone.toString(),
                  'Appeler',
                  () => _makePhoneCall(phone),
                ),
              ),
              buildCard(
                child: buildClickableDetailRow(
                  Icons.location_on,
                  'Addresse',
                  address,
                  'Open in maps',
                  () => _openInMaps(address),
                ),
              ),
              buildCard(
                child:
                    buildDetailRow(Icons.person, 'Nom complet', completeName),
              ),
              buildCard(
                color: _getColieStateColor(colieState),
                child: buildDetailRow(
                    Icons.access_time, 'état de Colie', colieState),
              ),
              buildCard(
                child: buildDetailRow(Icons.schedule, 'Temps', time),
              ),
              buildCard(
                child: buildDetailRow(Icons.money, 'Montant', '$amount TND'),
              ),
              buildCard(
                child: buildDetailRow(
                    Icons.person_pin, 'Destinataire \nInfo', recipientInfo),
              ),
              buildCard(
                child: buildDetailRow(Icons.supervisor_account,
                    'Fournisseur \nInfo', supplierInfo),
              ),
            ],
          ),
        ),
      );

  Widget buildCard({required Widget child, Color? color}) {
    return GestureDetector(
      child: Card(
        color: color ??
            Colors
                .white, // Set card background to white if no color is specified
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: child),
      ),
    );
  }

  Color _getColieStateColor(String state) {
    switch (state) {
      case 'in stock':
        return Colors.indigoAccent[100]!;
      case 'in return':
        return Colors.red;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget buildDetailRow(IconData iconData, String title, String detail) {
    return Center(
      child: Row(
        children: [
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 40,
                color: Colors.blue,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                detail,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildClickableDetailRow(IconData iconData, String title, String detail,
      String actionText, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 30,
                color: Colors.blue,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              InkWell(
                onTap: onPressed,
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _makePhoneCall(int phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openInMaps(String address) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$address';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
