import 'package:flutter/material.dart';

import '../../../services/admin/gallery_service.dart';

import 'add_gallery_screen.dart';
import 'edit_gallery_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    super.key,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List galleries = [];

  List filteredGallery = [];

  bool isLoading = true;

  String selectedCategory = "Semua Kategori";

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getGallery();
  }

  Future<void> getGallery() async {
    try {
      final result = await GalleryService().getGallery();

      setState(() {
        galleries = result;

        filteredGallery = result;

        isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  void filterGallery() {
    final keyword = searchController.text.toLowerCase();

    final result = galleries.where((gallery) {
      final title = gallery['title'].toString().toLowerCase();

      final category = gallery['category'].toString();

      final matchSearch = title.contains(keyword);

      final matchCategory =
          selectedCategory == "Semua Kategori" || category == selectedCategory;

      return matchSearch && matchCategory;
    }).toList();

    setState(() {
      filteredGallery = result;
    });
  }

  Widget categoryButton(
    String title,
  ) {
    final isActive = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });

        filterGallery();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            const Text(
              "🖼 ",
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Galeri Sekolah",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddGalleryScreen(),
            ),
          );

          getGallery();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      filterGallery();
                    },
                    decoration: InputDecoration(
                      hintText: "Cari galeri...",
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      categoryButton(
                        "Semua Kategori",
                      ),
                      categoryButton(
                        "Kegiatan Belajar",
                      ),
                      categoryButton(
                        "Outdoor",
                      ),
                      categoryButton(
                        "Keagamaan",
                      ),
                      categoryButton(
                        "Acara",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: filteredGallery.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada galeri",
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filteredGallery.length,
                          itemBuilder: (context, index) {
                            final gallery = filteredGallery[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 18),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      gallery['image'],
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      headers: const {
                                        "Connection": "keep-alive",
                                      },
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }

                                        return Container(
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey.shade100,
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        print(error);

                                        return Container(
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey.shade200,
                                          child: const Icon(
                                            Icons.broken_image,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          gallery['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Wrap(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.orange
                                                    .withOpacity(0.12),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                gallery['category'],
                                                style: const TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 44,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.teal,
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditGalleryScreen(
                                                          gallery: gallery,
                                                        ),
                                                      ),
                                                    );

                                                    getGallery();
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
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: SizedBox(
                                                height: 44,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    final result =
                                                        await GalleryService()
                                                            .deleteGallery(
                                                      gallery['id'],
                                                    );

                                                    if (result) {
                                                      await getGallery();

                                                      if (!mounted) return;

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Galeri berhasil dihapus",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Hapus",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
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
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}