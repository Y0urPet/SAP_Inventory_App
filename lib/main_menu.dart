import 'package:flutter/material.dart';
import 'package:sap_inventory_management/item_data.dart';
import 'package:sap_inventory_management/login.dart';
import 'item_data.dart';
import 'item.dart';
import 'about_us.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context,BoxConstraints constraints) {
          if (constraints.maxWidth <= 1200) {
            return const MyHomePage();
          } else {
            return ItemGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}

class ItemGrid extends StatefulWidget {
  final int gridCount;

  ItemGrid({required this.gridCount});

  @override
  State<ItemGrid> createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
  String itemName = '';
  String itemStock = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Item List'),
        leading: BackButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyOnboardingPage();
            }));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutUsPage();
              }));
            },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Scrollbar(
            isAlwaysShown: true,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GridView.count(
                crossAxisCount: widget.gridCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: itemData.map((place) {
                  return InkWell(
                    onLongPress: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                                content: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context){
                                                  return AlertDialog(
                                                      content: Padding(
                                                          padding: const EdgeInsets.all(16.0),
                                                          child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                TextField(
                                                                  decoration: const InputDecoration(
                                                                    hintText: 'Insert New Item Name...',
                                                                    labelText: 'Item Name',
                                                                  ),
                                                                  onChanged: (String value) {
                                                                    setState(() {
                                                                      itemName = value;
                                                                    });
                                                                  },
                                                                ),
                                                                const SizedBox(height: 20),
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    place.itemName = itemName;
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                      return const MainScreen();
                                                                    }));
                                                                  },
                                                                  child: const Text('Next'),
                                                                ),
                                                              ]
                                                          )
                                                      )
                                                  );
                                                });
                                          },
                                          child: const Text('Edit Item Name'),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            itemData.remove(place);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return const MainScreen();
                                            }));
                                            showDialog(
                                                context: context,
                                                builder: (context){
                                                  return const AlertDialog(
                                                    content: Text('Item Successfully deleted!'),
                                                  );
                                                });
                                          },
                                          child: const Text('Delete Item'),
                                        ),
                                      ],
                                    )
                                )
                            );
                          }
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Item Name:\n${place.itemName}',
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,bottom: 8.0),
                            child: Text(
                              'Item Stock:\n${place.itemStock.toString()}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                    content: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Insert Item Name...',
                                labelText: 'Item Name',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  itemName = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                          content: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      decoration: const InputDecoration(
                                                        hintText: 'Insert Item Stock...',
                                                        labelText: 'Item Stock',
                                                      ),
                                                      keyboardType: TextInputType.number,
                                                      onChanged: (String value) {
                                                        setState(() {
                                                          itemStock = value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 20),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        int stockQuantity = int.parse(itemStock);
                                                        Item item = Item(itemName, stockQuantity);
                                                        itemData.add(item);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return const MainScreen();
                                                        }));
                                                      },
                                                      child: const Text('Next'),
                                                    ),
                                                  ]
                                              )
                                          )
                                      );
                                    });
                              },
                              child: const Text('Next'),
                            ),
                          ],
                        )
                    )
                );
              }
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String itemName = '';
  String itemStock = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Item List'),
        leading: BackButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyOnboardingPage();
            }));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutUsPage();
              }));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Item place = itemData[index];
          return InkWell(
            onLongPress: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                        content: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                              content: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'Insert New Item Name...',
                                                            labelText: 'Item Name',
                                                          ),
                                                          onChanged: (String value) {
                                                            setState(() {
                                                              itemName = value;
                                                            });
                                                          },
                                                        ),
                                                        const SizedBox(height: 20),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            place.itemName = itemName;
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                              return const MainScreen();
                                                            }));
                                                          },
                                                          child: const Text('Next'),
                                                        ),
                                                      ]
                                                  )
                                              )
                                          );
                                        });
                                  },
                                  child: const Text('Edit Item Name'),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    itemData.remove(place);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return const MainScreen();
                                    }));
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return const AlertDialog(
                                              content: Text('Item Successfully deleted!'),
                                          );
                                        });
                                  },
                                  child: const Text('Delete Item'),
                                ),
                              ],
                            )
                        )
                    );
                  }
              );
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Item Name: ${place.itemName}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Item Stock: ${place.itemStock.toString()}'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: itemData.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                    content: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Insert Item Name...',
                                labelText: 'Item Name',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  itemName = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                        content: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                decoration: const InputDecoration(
                                                  hintText: 'Insert Item Stock...',
                                                  labelText: 'Item Stock',
                                                ),
                                                keyboardType: TextInputType.number,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    itemStock = value;
                                                  });
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  int stockQuantity = int.parse(itemStock);
                                                  Item item = Item(itemName, stockQuantity);
                                                  itemData.add(item);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    return const MainScreen();
                                                  }));
                                                },
                                                child: const Text('Next'),
                                              ),
                                            ]
                                          )
                                        )
                                      );
                                    });
                              },
                              child: const Text('Next'),
                            ),
                          ],
                        )
                    )
                );
              }
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

