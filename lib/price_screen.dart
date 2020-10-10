import 'package:bitcoin_ticker/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import '';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}
// b0077d37-1ea4-4342-8378-d4e91efdb613

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcPrice = "?", ltcPrice = "?", ethPrice = "?";

  FixedExtentScrollController _fixedExtentScrollController;

  List<DropdownMenuItem<String>> _getDropdownItemsList() {
    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i < currenciesList.length; i++) {
      list.add(
        DropdownMenuItem(
          child: Text(currenciesList[i]),
          value: currenciesList[i],
        ),
      );
    }
    return list;
  }

  List<Text> _getCupertinoItemsList() {
    List<Text> list = [];
    for (String currency in currenciesList) {
      list.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
    }
    return list;
  }

  NetworkHelper networkHelper = NetworkHelper();

  @override
  void initState() {
    super.initState();
    _fixedExtentScrollController= FixedExtentScrollController(initialItem: currenciesList.indexOf("USD"));
    getPriceData();
  }

  void getPriceData() async {
      print("get price data called");
      String bPrice = await networkHelper.getBitcoinPriceData(selectedCurrency);
      setState(() {
        btcPrice=bPrice;
      });
      String ePrice = await networkHelper.getEtheriumPriceData(selectedCurrency);
      setState(() {
        ethPrice=ePrice;
      });
      String lPrice = await networkHelper.getLitecoinPriceData(selectedCurrency);
      setState(() {
        ltcPrice=lPrice;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        actions: <Widget>[
          IconButton(
            enableFeedback: true,
            onPressed: (){
              print("refresh");
              getPriceData();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              useMagnifier: true,
              scrollController: _fixedExtentScrollController,
              squeeze: 1,
              itemExtent: 32,
              onSelectedItemChanged: (selectedIndex) async {
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                  btcPrice="?";
                  ethPrice="?";
                  ltcPrice="?";
                });
                getPriceData();
              },
              children: _getCupertinoItemsList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _fixedExtentScrollController.dispose();
  }
}

// DropdownButton<String>(
// elevation: 10,
// hint: Text("Currency"),
// onTap: (){
// print("tapped");
// },
// isExpanded: false,
// value: selectedCurrency,
// items: _getDropdownItemsList(),
// onChanged: (value){
// print(value);
// setState(() {
// selectedCurrency=value;
// });
// },
// ),
