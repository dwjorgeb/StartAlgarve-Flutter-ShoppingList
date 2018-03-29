import 'package:flutter/material.dart';

void main() => runApp(new ShoppingListApp());

class ShoppingListApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Shopping List',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      // PUT YOUR CODE HERE
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _biggerFont = const TextStyle(fontSize: 18.0);

  List<String> _items = ['Pinaple','Sugar'];
  List<String> _favorites = [];

  final TextEditingController _controller = new TextEditingController();

  void _addItem(s) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // PUT YOUR CODE HERE
      _controller.text = '';
    });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _favorites.map(
                (item) {
              return new ListTile(
                title: new Text(
                  item,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Favorites'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildShoppingList() {
    return new ListView.builder(
        itemCount: _items.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (context, i) {
          return _buildRow(_items[i]);
        }
    );
  }

  Widget _buildRow(String item) {
    final isFavorite = _favorites.contains(item);
    return new GestureDetector(
        onHorizontalDragEnd: (e) {
          setState(() {
            _items.remove(item);
            _favorites.remove(item);
          });
        },
        child: new ListTile(
                  title: new Text(
                  item,
                  style: _biggerFont,
                ),
                trailing: new Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  // PUT YOUR CODE HERE
                ),
                onTap: () {
                  setState(() {
                    if (isFavorite) {
                      _favorites.remove(item);
                    } else {
                      _favorites.add(item);
                    }
                  });
                },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _addItem method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: new Column(
        children: [
          new Container(
            padding: new EdgeInsets.all(10.0),
            child: new TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: 'type in item...',
              ),
              onSubmitted: _addItem,
            ),
          ),
          _buildShoppingList(),
        ],
      )
    );
  }
}
