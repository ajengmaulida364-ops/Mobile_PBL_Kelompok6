import 'package:flutter/material.dart';

import 'add_structure_screen.dart';
import 'edit_structure_screen.dart';
import '../../../services/admin/structure_service.dart';

class StructureScreen extends StatefulWidget {
  const StructureScreen({
    super.key,
  });

  @override
  State<StructureScreen> createState() => _StructureScreenState();
}

class _StructureScreenState extends State<StructureScreen> {
  List structures = [];

  bool isLoading = true;

  String selectedType = 'kepala';

  @override
  void initState() {
    super.initState();

    getStructures();
  }

  Future<void> getStructures() async {
    try {
      setState(() {
        isLoading = true;
      });

      final data = await StructureService().getStructures(
        type: selectedType,
      );

      setState(() {
        structures = data;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print(e);
    }
  }

  Future<void> deleteStructure(int id) async {
    try {
      await StructureService().deleteStructure(id);

      getStructures();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Struktur berhasil dihapus',
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Struktur Organisasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddStructureScreen(),
            ),
          );

          if (result == true) {
            getStructures();
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          /// FILTER
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _filterButton(
                  'kepala',
                  '👨‍💼 Kepala',
                ),
                const SizedBox(width: 10),
                _filterButton(
                  'guru',
                  '👩‍🏫 Guru',
                ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : structures.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada data struktur',
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: getStructures,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: structures.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            final item = structures[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    /// IMAGE
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: item['image'] != null
                                          ? Image.network(
                                              item['image'],
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Container(
                                                  width: 80,
                                                  height: 80,
                                                  color: Colors.grey[300],
                                                  child: const Icon(
                                                    Icons.person,
                                                  ),
                                                );
                                              },
                                            )
                                          : Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: const Icon(
                                                Icons.person,
                                              ),
                                            ),
                                    ),

                                    const SizedBox(width: 16),

                                    /// CONTENT
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            item['position'],
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            item['description'] ?? '-',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                  ),
                                                  onPressed: () async {
                                                    final result =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditStructureScreen(
                                                          structure: item,
                                                        ),
                                                      ),
                                                    );

                                                    if (result == true) {
                                                      getStructures();
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    deleteStructure(
                                                      item['id'],
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Hapus',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(
    String type,
    String title,
  ) {
    final isActive = selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedType = type;
          });

          getStructures();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: isActive ? Colors.orange : Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}