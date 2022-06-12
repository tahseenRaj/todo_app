import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todo = ['Item 1'];

  final myController = TextEditingController();
  final alertController = TextEditingController();

  void addToList() {
    setState(() {
      if (myController.text == '') {}
      else{todo.add(myController.text);}
      
      myController.clear();
    });
  }

  void removeFromList(index) {
    setState(() {
      todo.removeAt(index);
    });
  }

  void editTodo(index) {
    setState(() {
      todo[index] = alertController.text;
      alertController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
          child: TextFormField(
            controller: myController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Add to list!',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              color: Colors.blue,
                onPressed: () {
                  addToList();
                },
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.black,
                  size: 25,
                )),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          TextEditingController().clear();
        },
        child: ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 6,
                margin: const EdgeInsets.all(5),
                child: ListTile(
                    tileColor: Colors.white,
                    title: Text(todo[index]),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit_note_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Edit'),
                                  content: TextField(
                                    controller: alertController,
                                    decoration: InputDecoration(
                                        hintText: "${todo[index]}"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('SUBMIT'),
                                      onPressed: () {
                                        editTodo(index);
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                            }
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              removeFromList(index);
                            }
                          ),
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
