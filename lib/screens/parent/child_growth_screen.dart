import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import '../../services/parent/growth_service.dart';

class ChildGrowthScreen extends StatefulWidget {
  const ChildGrowthScreen({super.key});

  @override
  State<ChildGrowthScreen> createState() =>
      _ChildGrowthScreenState();
}

class _ChildGrowthScreenState
    extends State<ChildGrowthScreen> {

String? selectedMonth;
String? selectedYear;

String displayDate = 'Pilih Bulan';
final List<String> months = [

  'Jan',
  'Feb',
  'Mar',
  'Apr',

  'Mei',
  'Jun',
  'Jul',
  'Agu',

  'Sep',
  'Okt',
  'Nov',
  'Des',
];

  late Future<List<dynamic>> growthFuture;

  @override
  void initState() {
    super.initState();

    growthFuture =
        GrowthService().getGrowths();
  }

Future<void> pickMonthYear() async {

  int selectedYearTemp =
      DateTime.now().year;

  await showDialog(
    context: context,

    builder: (context) {

      return StatefulBuilder(

        builder: (
          context,
          setDialogState,
        ) {

          return AlertDialog(

            title: const Text(
              'Pilih Bulan',
            ),

            content: SizedBox(

              width: 320,

              child: Column(

                mainAxisSize:
                    MainAxisSize.min,

                children: [

                  DropdownButton<int>(

                    value:
                        selectedYearTemp,

                    isExpanded: true,

                    items:
                        List.generate(
                      16,
                      (index) {

                        final year =
                            2020 +
                                index;

                        return DropdownMenuItem(
                          value: year,

                          child: Text(
                            year.toString(),
                          ),
                        );
                      },
                    ),

                    onChanged:
                        (value) {

                      if (value == null) {
                        return;
                      }

                      setDialogState(() {

                        selectedYearTemp =
                            value;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  GridView.builder(

                    shrinkWrap: true,

                    itemCount:
                        months.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 3,

                      mainAxisSpacing: 8,

                      crossAxisSpacing: 8,
                    ),

                    itemBuilder:
                        (
                      context,
                      index,
                    ) {

                      return ElevatedButton(

                        onPressed: () {

                          setState(() {

                            selectedMonth =
                                (index + 1).toString();

                            selectedYear =
                                selectedYearTemp.toString();

                            displayDate =
                                "${months[index]} $selectedYearTemp";
                          });

                          Navigator.pop(context);
                        },

                        style: ElevatedButton.styleFrom(

                          padding: EdgeInsets.zero,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),

                        child: FittedBox(

                          fit: BoxFit.scaleDown,

                          child: Text(
                            months[index],

                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Perkembangan Anak",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<List<dynamic>>(

        future: growthFuture,

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
                "Belum ada data perkembangan",
              ),
            );
          }

          final growths = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// HERO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),

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

                  child: const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Perkembangan Anak",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Monitoring tinggi dan berat badan anak",

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                /// FILTER
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                            20),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey
                            .withValues(
                                alpha: 0.08),

                        blurRadius: 8,

                        offset:
                            const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Expanded(
                        child: Container(
                          height: 54,

                          decoration:
                              BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        14),

                            border: Border.all(
                              color: Colors
                                  .grey
                                  .shade300,
                            ),
                          ),

                          child: Row(
                            children: [

                              const SizedBox(
                                  width: 14),

                              const Icon(
                                Icons
                                    .calendar_month,
                                color:
                                    Colors
                                        .deepPurple,
                                size: 20,
                              ),

                              const SizedBox(
                                  width: 12),

                              Expanded(
                                child: InkWell(
                                  onTap: pickMonthYear,

                                  child: Align(
                                    alignment: Alignment.centerLeft,

                                    child: Text(
                                      displayDate,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const Padding(
                                padding:
                                    EdgeInsets.only(
                                        right:
                                            14),

                                child: Icon(
                                  Icons
                                      .calendar_today,
                                  color: Colors
                                      .black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      SizedBox(
                        width: 90,
                        height: 54,

                        child: ElevatedButton(
                          onPressed: () {

                            if (selectedMonth == null ||
                                selectedYear == null) {
                              return;
                            }

                            setState(() {

                              growthFuture =
                                  GrowthService()
                                      .getGrowths(
                                month: selectedMonth,
                                year: selectedYear,
                              );
                            });
                          },

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                                    0xffF59E0B),

                            elevation: 0,

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
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 15,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// CARD TB BB
                Row(
                  children: [

                    Expanded(
                      child: growthCard(
                        title:
                            "Tinggi Badan",

                        value:
                            growths.first['tb'] ??
                                '-',

                        icon:
                            Icons.height,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: growthCard(
                        title:
                            "Berat Badan",

                        value:
                            growths.first['bb'] ??
                                '-',

                        icon: Icons
                            .monitor_weight,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                /// CHART TB
                chartCard(
                  title: "Grafik Tinggi Badan",
                  growths: growths,
                  field: 'tb',
                ),
                const SizedBox(height: 22),

                /// CHART BB
                chartCard(
                  title: "Grafik Berat Badan",
                  growths: growths,
                  field: 'bb',
                ),

                const SizedBox(height: 28),

                const Text(
                  "Riwayat Perkembangan",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 18),

                /// LIST
                ListView.builder(
                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount:
                      growths.length,

                  itemBuilder:
                      (context, index) {

                    final item =
                        growths[index];

                    return Container(
                      margin:
                          const EdgeInsets.only(
                        bottom: 18,
                      ),

                      padding:
                          const EdgeInsets.all(
                              20),

                      decoration:
                          BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                                    20),

                        boxShadow: [

                          BoxShadow(
                            color: Colors
                                .grey
                                .withValues(
                                    alpha:
                                        0.08),

                            blurRadius: 8,

                            offset:
                                const Offset(
                                    0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(
                            item['date'] ??
                                '-',

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize: 20,
                            ),
                          ),

                          const SizedBox(
                              height: 12),

                          Text(
                            item['description'] ??
                                '-',

                            style:
                                const TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(
                              height: 20),

                          infoRow(
                            icon:
                                Icons.height,

                            text:
                                "Tinggi Badan : ${item['tb']}",
                          ),

                          const SizedBox(
                              height: 16),

                          infoRow(
                            icon: Icons
                                .monitor_weight,

                            text:
                                "Berat Badan : ${item['bb']}",
                          ),
                        ],
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

  
  Widget chartCard({
    required String title,
    required List<dynamic> growths,
    required String field,
  }) {

    final spots = <FlSpot>[];

    for (int i = 0; i < growths.length; i++) {
      final value = double.tryParse(
        growths[i][field].toString(),
      ) ?? 0;

      spots.add(
        FlSpot(
          i.toDouble(),
          value,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget infoRow({
    required IconData icon,
    required String text,
  }) {

    return Row(
      children: [

        Container(
          padding:
              const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: const Color(
                0xffE6F7F5),

            borderRadius:
                BorderRadius.circular(
                    12),
          ),

          child: Icon(
            icon,
            color:
                const Color(0xff0F9D94),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            text,

            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget growthCard({
    required String title,
    required String value,
    required IconData icon,
  }) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(
            color: Colors.grey
                .withValues(alpha: 0.08),

            blurRadius: 8,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [

          Container(
            padding:
                const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color:
                  const Color(0xffE6F7F5),

              borderRadius:
                  BorderRadius.circular(
                      14),
            ),

            child: Icon(
              icon,
              color:
                  const Color(0xff0F9D94),
              size: 28,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,

            textAlign:
                TextAlign.center,

            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,

            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}