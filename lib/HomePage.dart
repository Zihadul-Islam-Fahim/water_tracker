import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WaterTrack> waterConsumeList = [];
  final TextEditingController _amountOfGlass = TextEditingController(text: '1');
  int totalConsume = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(hexColor('#abcdef')),
        title: const Text('WaterTracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQbZEW06wLQhLapEX4s1L7FUjB0XKYUDro5tCD-d3c0PfqdXRDslGKO3Wk59YIIH062AE&usqp=CAU'),
                      alignment: Alignment.center,
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Consume',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '   $totalConsume',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Padding(padding: EdgeInsets.only(right: 20)),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: TextField(
                        controller: _amountOfGlass,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            int amount =
                                int.tryParse(_amountOfGlass.text.trim()) ?? 1;
                            totalConsume += amount;
                            WaterTrack waterTrack =
                                WaterTrack(DateTime.now(), amount);
                            waterConsumeList.add(waterTrack);
                            _amountOfGlass.text = '1';
                            setState(() {});
                          },
                          child: const Text('Add')),
                    )
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: waterConsumeList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 1,
                      borderOnForeground: true,
                      child: ListTile(
                        leading: CircleAvatar(
                            child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                        title: Text(
                          DateFormat('H:M:ss    dd-MM-yy')
                              .format(waterConsumeList[index].time),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        trailing: Text(
                          '${waterConsumeList[index].noOfGlass}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete'),
                                  content:
                                      const Text('Are you Want to Delete?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cencel')),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            totalConsume -=
                                                waterConsumeList[index]
                                                    .noOfGlass;
                                            waterConsumeList.removeAt(index);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text('Delete'))
                                  ],
                                );
                              });
                        },
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class WaterTrack {
  final DateTime time;
  final int noOfGlass;

  WaterTrack(this.time, this.noOfGlass);
}
