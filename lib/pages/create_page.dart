import 'package:flutter/material.dart';
import 'package:patterns_setstate/service/log_service.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';

class CreatePage extends StatefulWidget {
  final bool isUpdate;
  final int? postId;
  final String? title;
  final String? body;
  const CreatePage(
      {super.key, required this.isUpdate, this.postId, this.title, this.body});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  @override
  void initState() {
    titleController = widget.isUpdate
        ? TextEditingController(text: widget.title)
        : TextEditingController(text: '');

    bodyController = widget.isUpdate
        ? TextEditingController(text: widget.body)
        : TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      TextField(
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w500),
                        controller: titleController,
                        cursorColor: Colors.black54,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        maxLines: 5,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            contentPadding: const EdgeInsets.all(5),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black54),
                            ),
                            alignLabelWithHint: true,
                            labelText: 'Title',
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey,
                            ))),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w500),
                        controller: bodyController,
                        cursorColor: Colors.black54,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        maxLines: 5,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            contentPadding: const EdgeInsets.all(5),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black54),
                            ),
                            alignLabelWithHint: true,
                            labelText: 'Body',
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey,
                            ))),
                      ),
                      const SizedBox(height: 100),
                      MaterialButton(
                        color: Colors.blueAccent.shade100,
                        shape: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        height: 50,
                        minWidth: 200,
                        onPressed: () {
                          _doPostCreate();
                        },
                        child: widget.isUpdate
                            ? const Text('Update Post')
                            : const Text('Create Post'),
                      ),
                    ],
                  ),
                ],
              )),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Future _doPostCreate() async {
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    if (title.isEmpty || body.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    var post = Post(userId: 1, title: title, body: body);
    var post2 = Post(userId: 1, title: title, body: body, id: widget.postId);

    widget.isUpdate ? await apiPostUpdate(post2) : await apiPostCreate(post);
    Navigator.pop(context, true);
  }

  Future<void> apiPostCreate(Post post) async {
    await Network.POST(Network.apiCreate, Network.paramsCreate(post))
        .then((response) => {
              setState(() {
                isLoading = false;
              }),
            });
  }

  Future<void> apiPostUpdate(Post post) async {
    await Network.PUT(
            Network.apiUpdate + post.id.toString(), Network.paramsUpdate(post))
        .then((response) => {
              LogService.e('update : $response'),
              setState(() {
                isLoading = false;
              }),
            });
  }
}
