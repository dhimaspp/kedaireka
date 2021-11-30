// ignore_for_file: prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/theme/constant.dart';

class DetailAnalyze extends StatefulWidget {
  const DetailAnalyze(
      {Key? key,
      required this.gambarTerkait,
      required this.deskripsi,
      required this.treatment,
      required this.classType})
      : super(key: key);
  final List<String> gambarTerkait;
  final String deskripsi;
  final String treatment;
  final String classType;

  @override
  _DetailAnalyzeState createState() => _DetailAnalyzeState();
}

class _DetailAnalyzeState extends State<DetailAnalyze>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String>? gambarThumbnail;
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gambarThumbnail = widget.gambarTerkait;
    _tabController = TabController(vsync: this, length: 2);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 310,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: kMaincolor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 42),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width / 2 - 50),
                            child: Text(
                              widget.classType,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 360,
                      margin:
                          const EdgeInsets.only(left: 24, right: 24, top: 8),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                spreadRadius: -2,
                                blurRadius: 8,
                                offset: Offset(0, 4))
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(19))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 230,
                            width: Get.width,
                            child: CachedNetworkImage(
                              imageUrl: widget.gambarTerkait[_selectedIndex],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            width: Get.width,
                            height: 130,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: false,
                                itemCount: gambarThumbnail!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: _selectedIndex == index
                                              ? Border.all(
                                                  color: kMaincolor, width: 3)
                                              : null,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      margin: const EdgeInsets.only(right: 18),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        child: CachedNetworkImage(
                                          imageUrl: gambarThumbnail![index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 18),
              // height: ,
              constraints: const BoxConstraints(maxHeight: 80.0, maxWidth: 300),
              child: TabBar(
                labelPadding: const EdgeInsets.only(bottom: 12),
                controller: _tabController,
                labelColor: kMaincolor,
                unselectedLabelColor: Colors.black54,
                indicatorColor: kMaincolor,
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (index) {},
                tabs: const [
                  SizedBox(
                    child: Text(
                      'Deskripsi',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      'Pengendalian',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: TabBarView(controller: _tabController, children: [
              LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: Get.height),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.deskripsi,
                        style: const TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                );
              }),
              LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: Get.height),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.treatment,
                        style: const TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                );
              })
            ]))
          ],
        ),
      ),
    );
  }
}
