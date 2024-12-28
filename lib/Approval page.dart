import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DownloadApprovalsPage extends StatefulWidget {
  DownloadApprovalsPage({Key? key}) : super(key: key);

  @override
  State<DownloadApprovalsPage> createState() => _DownloadApprovalsPageState();
}

class _DownloadApprovalsPageState extends State<DownloadApprovalsPage> with SingleTickerProviderStateMixin {
  final List<String> collections = [
    'Birthday',
    'Graduation',
    'Inauguration',
    'Seminar',
    'Wedding',
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildList(String statusFilter) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, collectionIndex) {
        String collection = collections[collectionIndex];

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(collection)
              .where('Status', isEqualTo: statusFilter)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data.'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No $statusFilter designs in $collection.'));
            }

            final documents = snapshot.data!.docs;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    collection,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final data = documents[index].data() as Map<String, dynamic>;
                    final docId = documents[index].id;

                    final email = data['Mail'] ?? 'No Email';
                    final status = data['Status'] ?? 'No Status';

                    String title = data['Title'] ?? data['Name'] ?? data['ShopName'] ?? 'No Title';
                    String location = data['Location'] ?? 'No Location';
                    String dateTime = data['DateTime'] ?? data['Time'] ?? data['Date'] ?? 'No Date/Time';

                    return Flexible(
                      child: Container(
                       // height: 250,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            title,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: $email'),
                              Text('Location: $location'),
                              Text('Date/Time: $dateTime'),
                              Text('Status: $status', style: const TextStyle(color: Colors.orange)),
                              const SizedBox(height: 10),
                              if (statusFilter == 'pending') // Conditional rendering of buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection(collection)
                                            .doc(docId)
                                            .update({'Status': 'approved'});
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Status updated to Approved')),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: const Text('Approve'),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection(collection)
                                            .doc(docId)
                                            .update({'Status': 'declined'});
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Status updated to Declined')),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text('Decline'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Approvals'),
        backgroundColor: const Color(0xFFf0ecff),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFf0ecff),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList('pending'),
          _buildList('approved'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
