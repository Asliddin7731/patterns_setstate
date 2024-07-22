import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_setstate/pages/create_page.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.apiList, Network.paramsEmpty());
    setState(() {
      isLoading = false;
      if (response != null) {
        items = Network.parsePostList(response);
      } else {
        items = [];
      }
    });
  }

  void _apiPostDelete(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.DEl(
        Network.apiDelete + post.id.toString(), Network.paramsEmpty());
    setState(() {
      if (response != null) {
        _apiPostList();
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    _apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('SetState'),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                return itemOfPost(items[index]);
              }),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () async {
          bool? isUpdate = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreatePage(isUpdate: false)));
          if (isUpdate != null) {
            _apiPostList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      startActionPane: ActionPane(
        dragDismissible: false,
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context)async {
              bool? isUpdate = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreatePage(
                        isUpdate: true,
                        postId: post.id,
                        title: post.title,
                        body: post.body,
                      ),
              ));
              if(isUpdate != null){
                _apiPostList();
              }
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Update',
          )
        ],
      ),
      endActionPane: ActionPane(
        dragDismissible: false,
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _apiPostDelete(post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!.toUpperCase()),
            const SizedBox(height: 5),
            Text(post.body!),
          ],
        ),
      ),
    );
  }
}
