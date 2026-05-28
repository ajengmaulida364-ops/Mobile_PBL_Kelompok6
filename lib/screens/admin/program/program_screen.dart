import 'package:flutter/material.dart';

import '../../../services/admin/program_service.dart';

import 'add_program_screen.dart';
import 'edit_program_screen.dart';

class ProgramScreen
    extends StatefulWidget {

  const ProgramScreen({
    super.key,
  });

  @override
  State<ProgramScreen>
      createState() =>
          _ProgramScreenState();
}

class _ProgramScreenState
    extends State<ProgramScreen> {

  List programs = [];

  bool isLoading = true;

  String selectedType =
      'mingguan';

  @override
  void initState() {

    super.initState();

    getPrograms();
  }

  Future<void> getPrograms() async {

    try {

      setState(() {

        isLoading = true;
      });

      final data =
          await ProgramService()
              .getPrograms(
        type: selectedType,
      );

      setState(() {

        programs = data;

        isLoading = false;
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });

      print(e);
    }
  }

  Future<void> deleteProgram(
      int id) async {

    try {

      await ProgramService()
          .deleteProgram(id);

      getPrograms();

      ScaffoldMessenger.of(
              context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Program berhasil dihapus',
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

      backgroundColor:
          const Color(
              0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        title: const Text(

          'Program Sekolah',

          style: TextStyle(

            color: Colors.white,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            Colors.orange,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () async {

          final result =
              await Navigator.push(

            context,

            MaterialPageRoute(

              builder:
                  (_) =>
                      const AddProgramScreen(),
            ),
          );

          if (result == true) {

            getPrograms();
          }
        },
      ),

      body: Column(

        children: [

          /// FILTER
          Container(

            padding:
                const EdgeInsets
                    .all(16),

            child: Row(

              children: [

                _filterButton(
                  'mingguan',
                  '📅 Mingguan',
                ),

                const SizedBox(
                    width: 10),

                _filterButton(
                  'bulanan',
                  '📅 Bulanan',
                ),

                const SizedBox(
                    width: 10),

                _filterButton(
                  'tahunan',
                  '📅 Tahunan',
                ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(

            child: isLoading

                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )

                : programs.isEmpty

                    ? const Center(

                        child: Text(
                          'Belum ada program',
                        ),
                      )

                    : RefreshIndicator(

                        onRefresh:
                            getPrograms,

                        child:
                            GridView.builder(

                          padding:
                              const EdgeInsets
                                  .all(16),

                          itemCount:
                              programs.length,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount:
                                2,

                            crossAxisSpacing:
                                16,

                            mainAxisSpacing:
                                16,

                            childAspectRatio:
                                0.62,
                          ),

                          itemBuilder:
                              (
                            context,
                            index,
                          ) {

                            final item =
                                programs[
                                    index];

                            return Container(

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white,

                                borderRadius:
                                    BorderRadius.circular(
                                        22),

                                boxShadow: [

                                  BoxShadow(

                                    color: Colors
                                        .black
                                        .withOpacity(
                                            0.05),

                                    blurRadius:
                                        10,

                                    offset:
                                        const Offset(
                                            0,
                                            5),
                                  ),
                                ],
                              ),

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  /// IMAGE
                                  ClipRRect(

                                    borderRadius:
                                        const BorderRadius.only(

                                      topLeft:
                                          Radius.circular(
                                              22),

                                      topRight:
                                          Radius.circular(
                                              22),
                                    ),

                                    child:
                                        Image.network(

                                      item[
                                          'image'],

                                      height:
                                          140,

                                      width:
                                          double.infinity,

                                      fit: BoxFit
                                          .cover,

                                      errorBuilder:
                                          (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {

                                        return Container(

                                          height:
                                              140,

                                          color:
                                              Colors.grey[
                                                  300],

                                          child:
                                              const Center(

                                            child:
                                                Icon(
                                              Icons
                                                  .image,
                                              size:
                                                  50,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  Expanded(

                                    child:
                                        Padding(

                                      padding:
                                          const EdgeInsets.all(
                                              14),

                                      child:
                                          Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [

                                          Text(

                                            item[
                                                'title'],

                                            maxLines:
                                                1,

                                            overflow:
                                                TextOverflow.ellipsis,

                                            style:
                                                const TextStyle(

                                              fontSize:
                                                  18,

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(
                                              height:
                                                  8),

                                          Expanded(

                                            child:
                                                Text(

                                              item[
                                                      'description'] ??
                                                  '-',

                                              maxLines:
                                                  3,

                                              overflow:
                                                  TextOverflow.ellipsis,

                                              style:
                                                  TextStyle(

                                                color:
                                                    Colors.grey[
                                                        700],

                                                height:
                                                    1.4,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                              height:
                                                  12),

                                          Row(

                                            children: [

                                              Expanded(

                                                child:
                                                    ElevatedButton(

                                                  style:
                                                      ElevatedButton.styleFrom(

                                                    backgroundColor:
                                                        Colors.orange,

                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                      vertical:
                                                          10,
                                                    ),

                                                    shape:
                                                        RoundedRectangleBorder(

                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),

                                                  onPressed:
                                                      () async {

                                                    final result =
                                                        await Navigator.push(

                                                      context,

                                                      MaterialPageRoute(

                                                        builder:
                                                            (_) =>
                                                                EditProgramScreen(
                                                          program:
                                                              item,
                                                        ),
                                                      ),
                                                    );

                                                    if (result ==
                                                        true) {

                                                      getPrograms();
                                                    }
                                                  },

                                                  child:
                                                      const Text(

                                                    'Edit',

                                                    style:
                                                        TextStyle(
                                                      color:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                  width:
                                                      8),

                                              Expanded(

                                                child:
                                                    ElevatedButton(

                                                  style:
                                                      ElevatedButton.styleFrom(

                                                    backgroundColor:
                                                        Colors.red,

                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                      vertical:
                                                          10,
                                                    ),

                                                    shape:
                                                        RoundedRectangleBorder(

                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),

                                                  onPressed:
                                                      () {

                                                    deleteProgram(
                                                      item['id'],
                                                    );
                                                  },

                                                  child:
                                                      const Text(

                                                    'Hapus',

                                                    style:
                                                        TextStyle(
                                                      color:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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

    final isActive =
        selectedType == type;

    return Expanded(

      child: GestureDetector(

        onTap: () {

          setState(() {

            selectedType =
                type;
          });

          getPrograms();
        },

        child: Container(

          padding:
              const EdgeInsets
                  .symmetric(
            vertical: 14,
          ),

          decoration: BoxDecoration(

            color: isActive

                ? Colors.orange

                : Colors.white,

            borderRadius:
                BorderRadius.circular(
                    14),
          ),

          child: Center(

            child: Text(

              title,

              style: TextStyle(

                color: isActive

                    ? Colors.white

                    : Colors.black,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}