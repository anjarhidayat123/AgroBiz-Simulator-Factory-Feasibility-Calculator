import 'package:agrobiz_simulator/models/simulation_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SimulationModel Logic Tests', () {
    test('Calculates Fixed Cost Correctly', () {
      final model = SimulationModel(
        laborCostPerMonth: 1000,
        energyCostPerMonth: 500,
        otherOperationalCostPerMonth: 500,
      );
      expect(model.fixedCostPerMonth, 2000);
    });

    test('Calculates BEP Correctly', () {
      // Fixed Cost: 2,000,000
      // Variable Cost per Unit: 10,000
      // Selling Price: 20,000
      // Contribution Margin: 10,000
      // BEP: 2,000,000 / 10,000 = 200 Units
      final model = SimulationModel(
        laborCostPerMonth: 2000000,
        rawMaterialCostPerUnit: 10000,
        sellingPricePerUnit: 20000,
      );
      expect(model.bepInUnits, 200);
    });

    test('Calculates Profit Correctly', () {
      // Fixed Cost: 1,000,000
      // Variable Cost: 5,000
      // Price: 10,000
      // Capacity: 500
      // Revenue: 5,000,000
      // Total Cost: 1,000,000 + (5,000 * 500) = 3,500,000
      // Profit: 1,500,000
      final model = SimulationModel(
        laborCostPerMonth: 1000000,
        rawMaterialCostPerUnit: 5000,
        sellingPricePerUnit: 10000,
        productionCapacityPerMonth: 500,
      );
      expect(model.netProfitPerMonth, 1500000);
    });
  });
}
