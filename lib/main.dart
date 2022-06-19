
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          home:MyApp()
      )
  );    // app 시작
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int a = 1;
  var name = ["김영숙", "정은희", "김희은"];
  var phone = ["000-000-0000", "000-5388-7868", "010-4388-7868"];
  var total = 3;

  addOne(value) {
    setState(() {
      total++;
      name.add(value);
      name.sort();
    });
  }

  deleteOne(value) {
    setState(() {
      name.removeAt(value);
      name.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(title: Text(total.toString())),
        body: ShopItem(name: name, phone: phone, deleteOne: deleteOne),
        bottomNavigationBar: BottomCustomWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(context.findAncestorWidgetOfExactType<MaterialApp>());
            showDialog(context: context, builder: (context) {
                  return CustomDialog(addOne: addOne);
                }
            );
          },
        ),
      );
  }
}

class CustomDialog extends StatelessWidget {
  CustomDialog({Key? key, this.addOne}) : super(key: key);

  final addOne;
  var inputDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(
              onChanged: (input) {
                inputDate = input;
              },
            ),
            TextButton(
                onPressed: () {
                  if(inputDate != null || inputDate.isNotEmpty) {
                    addOne(inputDate);
                    Navigator.pop(context);
                  }
                },
                child: Text('완료')
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소')
            )
          ],
        ),
      )
    );
  }
}


class BottomCustomWidget extends StatelessWidget {
  const BottomCustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.phone),
            Icon(Icons.message),
            Icon(Icons.account_balance_wallet_rounded)
          ],
        ),
      ),
    );
  }
}

class ShopItem extends StatefulWidget {
  ShopItem({Key? key, this.name, this.phone, this.deleteOne}) : super(key: key);
  var name;
  var phone;
  var deleteOne;

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.name.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: Image.asset("aaa.png"),
              title: Text(widget.name[i] + "   " + widget.phone[i]),
              trailing: TextButton(
                  onPressed: () {
                    widget.deleteOne(i);
                  },
                  child: Text('삭제')
              ),
            ),
          );
        }
    );
  }
}

