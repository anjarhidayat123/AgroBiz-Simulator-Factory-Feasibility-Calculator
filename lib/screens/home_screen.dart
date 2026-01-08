import 'package:flutter/material.dart';
import '../models/simulation_model.dart';
import 'input_view.dart';
import 'result_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Central State
  late SimulationModel _model;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _resetSimulation();
  }

  void _resetSimulation() {
    setState(() {
      _model = SimulationModel(
        // Default values for "Keripik Buah" case study (approximate)
        machineCost: 50000000,
        renovationCost: 10000000,
        permitCost: 5000000,
        rawMaterialCostPerUnit: 15000, // per kg or pack
        packagingCostPerUnit: 2000,
        laborCostPerMonth: 3000000, // 1 staff
        energyCostPerMonth: 500000,
        otherOperationalCostPerMonth: 500000,
        productionCapacityPerMonth: 1000,
        sellingPricePerUnit: 25000,
      );
    });
  }

  void _updateModel(SimulationModel newModel) {
    setState(() {
      _model = newModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroBiz Simulator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Simulasi',
            onPressed: _resetSimulation,
          ),
        ],
      ),
      body: isWideScreen
          ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InputView(
                        model: _model,
                        onChanged: _updateModel,
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ResultView(model: _model),
                    ),
                  ),
                ),
              ],
            )
          : _selectedIndex == 0
              ? SingleChildScrollView(
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InputView(
                    model: _model,
                    onChanged: _updateModel,
                  ),
                ))
              : SingleChildScrollView(
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ResultView(model: _model),
                )),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.calculate_outlined),
                  selectedIcon: Icon(Icons.calculate),
                  label: 'Input Data',
                ),
                NavigationDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: 'Analisis',
                ),
              ],
            ),
    );
  }
}
