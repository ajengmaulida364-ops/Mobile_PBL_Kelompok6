import 'package:flutter/material.dart';

import '../../services/parent/activity_service.dart';

class ChildActivityScreen extends StatefulWidget {
  const ChildActivityScreen({super.key});

  @override
  State<ChildActivityScreen> createState() =>
      _ChildActivityScreenState();
}

class _ChildActivityScreenState
    extends State<ChildActivityScreen> {

  late Future<List<dynamic>> activityFuture;

  @override
  void initState() {
    super.initState();

    activityFuture =
        ActivityService().getActivities();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Kegiatan Anak",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<List<dynamic>>(

        future: activityFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "Belum ada data kegiatan",
              ),
            );
          }

          final activities = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    gradient: const LinearGradient(

                      colors: [
                        Color(0xff0F766E),
                        Color(0xff0284C7),
                      ],

                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: const [

                      Text(
                        "Kegiatan Harian",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Aktivitas anak setiap hari di sekolah",

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                /// FILTER CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(20),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey
                            .withValues(
                          alpha: 0.08,
                        ),

                        blurRadius: 10,

                        offset:
                            const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Expanded(
                        child: TextField(

                          decoration: InputDecoration(

                            hintText:
                                "dd/mm/yyyy",

                            prefixIcon:
                                const Icon(
                              Icons.calendar_month,
                              color:
                                  Colors.purple,
                            ),

                            suffixIcon:
                                const Icon(
                                    Icons
                                        .calendar_today),

                            filled: true,
                            fillColor:
                                Colors.white,

                            contentPadding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),

                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          14),

                              borderSide:
                                  BorderSide(
                                color: Colors
                                    .grey
                                    .shade300,
                              ),
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          14),

                              borderSide:
                                  BorderSide(
                                color: Colors
                                    .grey
                                    .shade300,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      SizedBox(
                        height: 50,

                        child: ElevatedButton(
                          onPressed: () {},

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                Colors.orange,

                            elevation: 0,

                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 24,
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          14),
                            ),
                          ),

                          child: const Text(
                            "Filter",

                            style: TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// LIST ACTIVITY
                ListView.builder(
                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount:
                      activities.length,

                  itemBuilder:
                      (context, index) {

                    final item =
                        activities[index];

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 18,
                      ),

                      child: activityCard(
                        date:
                            item['date'] ?? '-',

                        day:
                            item['day'] ?? '-',

                        image:
                            item['image'] ?? '',

                        activities:
                            List<String>.from(
                          item['activities'] ??
                              [],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget activityCard({
    required String date,
    required String day,
    required String image,
    required List<String> activities,
  }) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(
            color: Colors.grey
                .withValues(
              alpha: 0.08,
            ),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Center(
            child: Text(
              "HASIL KARYA",

              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight:
                    FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          ClipRRect(
  borderRadius: BorderRadius.circular(20),

  child: image.isNotEmpty
      ? Image.network(
          image,
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
        )
      : Container(
          width: double.infinity,
          height: 220,
          color: Colors.grey.shade200,
          child: const Icon(
            Icons.image_not_supported,
            size: 60,
          ),
        ),
),

          const SizedBox(height: 16),

          Row(
            children: [

              Text(
                date,

                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),

              const SizedBox(width: 10),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color:
                      const Color(0xffEEF2FF),

                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),

                child: Text(
                  day,

                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Aktivitas Hari Ini",

            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Padding(
            padding:
                const EdgeInsets.only(
                    left: 8),

            child: Column(
              children:
                  activities.map((item) {

                return activityItem(item);

              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget activityItem(String text) {

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "• ",

            style: TextStyle(
              fontSize: 18,
              height: 1.4,
            ),
          ),

          Expanded(
            child: Text(
              text,

              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}