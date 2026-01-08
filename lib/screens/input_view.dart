import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/simulation_model.dart';

class InputView extends StatelessWidget {
  final SimulationModel model;
  final Function(SimulationModel) onChanged;

  const InputView({
    super.key,
    required this.model,
    required this.onChanged,
  });

  void _update(SimulationModel newModel) {
    onChanged(newModel);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Investasi Awal (CAPEX)'),
        _buildCurrencyInput(
          label: 'Harga Mesin',
          value: model.machineCost,
          onChanged: (val) =>
              _update(SimulationModelFactory.copyWith(model, machineCost: val)),
        ),
        _buildCurrencyInput(
          label: 'Renovasi Bangunan',
          value: model.renovationCost,
          onChanged: (val) => _update(
              SimulationModelFactory.copyWith(model, renovationCost: val)),
        ),
        _buildCurrencyInput(
          label: 'Perizinan & Lainnya',
          value: model.permitCost,
          onChanged: (val) =>
              _update(SimulationModelFactory.copyWith(model, permitCost: val)),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader('Biaya Operasional (OPEX)'),
        _buildCurrencyInput(
          label: 'Bahan Baku (per unit)',
          value: model.rawMaterialCostPerUnit,
          onChanged: (val) => _update(SimulationModelFactory.copyWith(model,
              rawMaterialCostPerUnit: val)),
        ),
        _buildCurrencyInput(
          label: 'Kemasan (per unit)',
          value: model.packagingCostPerUnit,
          onChanged: (val) => _update(
              SimulationModelFactory.copyWith(model, packagingCostPerUnit: val)),
        ),
        _buildCurrencyInput(
          label: 'Tenaga Kerja (per bulan)',
          value: model.laborCostPerMonth,
          onChanged: (val) => _update(
              SimulationModelFactory.copyWith(model, laborCostPerMonth: val)),
        ),
        _buildCurrencyInput(
          label: 'Listrik & Energi (per bulan)',
          value: model.energyCostPerMonth,
          onChanged: (val) => _update(
              SimulationModelFactory.copyWith(model, energyCostPerMonth: val)),
        ),
        _buildCurrencyInput(
          label: 'Lain-lain (per bulan)',
          value: model.otherOperationalCostPerMonth,
          onChanged: (val) => _update(SimulationModelFactory.copyWith(model,
              otherOperationalCostPerMonth: val)),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader('Target & Penjualan'),
        Row(
          children: [
            Expanded(
              child: Text(
                'Kapasitas Produksi: ${NumberFormat.decimalPattern('id').format(model.productionCapacityPerMonth)} unit/bulan',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Slider(
          value: model.productionCapacityPerMonth,
          min: 0,
          max: 10000,
          divisions: 100,
          label: model.productionCapacityPerMonth.round().toString(),
          onChanged: (val) => _update(SimulationModelFactory.copyWith(model,
              productionCapacityPerMonth: val)),
        ),
        _buildCurrencyInput(
          label: 'Harga Jual (per unit)',
          value: model.sellingPricePerUnit,
          onChanged: (val) => _update(
              SimulationModelFactory.copyWith(model, sellingPricePerUnit: val)),
        ),
        const SizedBox(height: 80), // Bottom padding
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2E7D32),
        ),
      ),
    );
  }

  Widget _buildCurrencyInput({
    required String label,
    required double value,
    required Function(double) onChanged,
  }) {
    // Note: Using a text controller would be better for complex input, but standard
    // rapid dev approach with TextFormField initialValue can work if key changes.
    // However, to avoid cursor jumps, we might simply use the onChanged and not
    // force rebuild the TextField content on every keystroke unless focus is lost.
    // For simplicity in this demo, let's use a specialized stateless wrapper
    // or just a simple text field that parses on change.
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: value == 0 ? '' : value.toInt().toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixText: 'Rp ',
          suffixText: 'IDR',
        ),
        onChanged: (val) {
          final double? numVal = double.tryParse(val.replaceAll('.', ''));
          if (numVal != null) {
            onChanged(numVal);
          }
        },
      ),
    );
  }
}

// Helper to copy model easily since Dart data classes aren't built-in
class SimulationModelFactory {
  static SimulationModel copyWith(
    SimulationModel original, {
    double? machineCost,
    double? renovationCost,
    double? permitCost,
    double? rawMaterialCostPerUnit,
    double? laborCostPerMonth,
    double? energyCostPerMonth,
    double? packagingCostPerUnit,
    double? otherOperationalCostPerMonth,
    double? productionCapacityPerMonth,
    double? sellingPricePerUnit,
  }) {
    return SimulationModel(
      machineCost: machineCost ?? original.machineCost,
      renovationCost: renovationCost ?? original.renovationCost,
      permitCost: permitCost ?? original.permitCost,
      rawMaterialCostPerUnit:
          rawMaterialCostPerUnit ?? original.rawMaterialCostPerUnit,
      laborCostPerMonth: laborCostPerMonth ?? original.laborCostPerMonth,
      energyCostPerMonth: energyCostPerMonth ?? original.energyCostPerMonth,
      packagingCostPerUnit: packagingCostPerUnit ?? original.packagingCostPerUnit,
      otherOperationalCostPerMonth:
          otherOperationalCostPerMonth ?? original.otherOperationalCostPerMonth,
      productionCapacityPerMonth:
          productionCapacityPerMonth ?? original.productionCapacityPerMonth,
      sellingPricePerUnit: sellingPricePerUnit ?? original.sellingPricePerUnit,
    );
  }
}
