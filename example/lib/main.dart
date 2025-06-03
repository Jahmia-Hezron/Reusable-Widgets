import 'package:flutter/material.dart';
import 'package:reusable_widgets/widget_exporter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reusable Widgets Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ReusableWidgetsDemo(),
    );
  }
}

class ReusableWidgetsDemo extends StatefulWidget {
  const ReusableWidgetsDemo({super.key});

  @override
  State<ReusableWidgetsDemo> createState() => _ReusableWidgetsDemoState();
}

class _ReusableWidgetsDemoState extends State<ReusableWidgetsDemo> {
  bool isLoading = false;
  String? dropdownValue;
  int selectedStatus = 3;
  final controller = TextEditingController();

  void _onButtonPressed() {
    setState(() => isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
      ReusableSnackbarWidget.show(context, "Button action completed!");
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {"ID": 1, "first_name": "Alice", "last_name": "Smith"},
      {"ID": 2, "first_name": "Bob", "last_name": "Johnson"},
      {"ID": 3, "first_name": "Charlie", "last_name": "Williams"},
    ];

    final statusMap = {
      1: 'Bad',
      2: 'Poor',
      3: 'Neutral',
      4: 'Good',
      5: 'Great',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Reusable Widgets Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ReusableCardWidget(
              child: ReusableTextFieldWidget(
                controller: controller,
                label: 'Enter your name',
              ),
            ),
            ReusableCardWidget(
              child: ReusableDropdownWidget(
                selectedValue: dropdownValue,
                items: items,
                label: 'Select User',
                onChanged: (value) {
                  setState(() => dropdownValue = value);
                },
              ),
            ),
            ReusableCardWidget(
              child: ReusableRadioButtonWidget(
                selectedStatus: selectedStatus,
                options: [1, 2, 3, 4, 5],
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedStatus = val);
                  }
                },
                statusMap: statusMap,
              ),
            ),
            ReusableCardWidget(
              child: ReusableButtonWidget(
                isLoading: isLoading,
                onPressed: _onButtonPressed,
                text: 'Submit',
              ),
            ),
            const SizedBox(height: 20),
            ReusablenavitemWidget(
              icon: Icons.dashboard,
              title: 'Sample Nav Item',
              screen: const Scaffold(
                body: Center(child: Text("Navigated Page")),
              ),
              onItemSelected: (screen) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => screen),
                );
              },
              textColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
