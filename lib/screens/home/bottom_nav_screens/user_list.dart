import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_application_it_grow/screens/home/bottom_nav_screens/open_trade_model.dart';
import 'package:test_application_it_grow/utils/api_service.dart';
import 'package:test_application_it_grow/utils/display_size.dart';
import 'package:test_application_it_grow/utils/urls.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  String loginId = "";
  String savedToken = "";
  List<OpenTradeModel> trades = [];
  double totalProfit = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    syncDataWithProvider().then((value) {
      getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profit :   $totalProfit",
          style: const TextStyle(color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        child: trades.isNotEmpty
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 10.0,
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _text("Current Price:"),
                                _text("Comment:"),
                                _text("Digits:"),
                                _text("Login:"),
                                _text("Open Price:"),
                                _text("Open Time:"),
                                _text("Profit:"),
                                _text("SL:"),
                                _text("Swap:"),
                                _text("Symbol:"),
                                _text("TP:"),
                                _text("Ticket:"),
                                _text("Type:"),
                                _text("Volume:"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _text("${trades[index].currentPrice}"),
                                _text("${trades[index].comment ?? "Empty"}"),
                                _text("${trades[index].digits}"),
                                _text("${trades[index].login}"),
                                _text("${trades[index].openPrice}"),
                                _text("${trades[index].openTime}"),
                                _text("${trades[index].profit}"),
                                _text("${trades[index].sl}"),
                                _text("${trades[index].swaps}"),
                                _text("${trades[index].symbol}"),
                                _text("${trades[index].tp}"),
                                _text("${trades[index].ticket}"),
                                _text("${trades[index].type}"),
                                _text("${trades[index].volume}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: trades.length,
                scrollDirection: Axis.vertical)
            : const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refresh();
        },
        child: const Icon(Icons.refresh_outlined),
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> getUserList() async {
    var body = {"login": loginId, "token": savedToken};
    var response = await ApiService().postRequest(Urls.getOpenTradesUrl, body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        trades = openTradeModelFromJson(response.body);
      });
      getProfit();
    } else {}
  }

  Future syncDataWithProvider() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? id = sharedPreferences.getString("id");
    String? token = sharedPreferences.getString("token");
    if (id != null && id.toString().isNotEmpty) {
      loginId = id;
      savedToken = token!;
      print(loginId);
      print(savedToken);
    } else {}
  }

  Widget _text(String s) {
    return Text(
      s,
      style: TextStyle(
          color: Colors.purple,
          fontSize: displayWidth(context) * 0.05,
          fontWeight: FontWeight.bold),
    );
  }

  void refresh() {
    setState(() {
      trades.clear();
      totalProfit = 0.0;
    });
    getUserList();
  }

  void getProfit() {
    trades.forEach((element) {
      totalProfit = totalProfit + element.profit!.toDouble();
    });
    setState(() {
      totalProfit;
    });
  }
}
