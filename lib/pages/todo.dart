import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({
    super.key,
    required this.title,
  });

  final String title;

  @override
  _Todo createState() => _Todo();
}

class _Todo extends State<Todo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final List<String> _addTask = [];
  List<bool> isSelected = [];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: _addTask.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Add rounded corners
                        side: const BorderSide(
                          color: Color.fromARGB(255, 202, 202, 202),
                          width: 1.0,
                        ),
                      ),
                      child: ListTile(
                        leading: IconButton(
                            onPressed: () {
                              setState(() {
                                isSelected[index] = !isSelected[index];
                              });
                            },
                            icon: Icon(!isSelected[index]
                                ? Icons.radio_button_off
                                : Icons.radio_button_on)),
                        title: Text(_addTask[index]),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _addTask.removeAt(index);
                              isSelected.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  validator: (newValue) {
                    if (newValue!.isEmpty) {
                      return 'Add a Task';
                    }
                    return null;
                  },
                  onFieldSubmitted: (newValue) {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        _addTask.add(newValue);
                        isSelected.add(false);
                        _controller.clear();
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.add),
                    hintText: 'Add Task',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
