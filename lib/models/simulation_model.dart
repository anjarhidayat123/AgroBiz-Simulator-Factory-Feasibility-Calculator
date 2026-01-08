class SimulationModel {
  // CAPEX (Modal Awal)
  double machineCost;
  double renovationCost;
  double permitCost;

  // OPEX (Biaya Operasional per Unit/Bulan)
  double rawMaterialCostPerUnit;
  double laborCostPerMonth;
  double energyCostPerMonth;
  double packagingCostPerUnit;
  double otherOperationalCostPerMonth;

  // Target
  double productionCapacityPerMonth;
  double sellingPricePerUnit;

  SimulationModel({
    this.machineCost = 0,
    this.renovationCost = 0,
    this.permitCost = 0,
    this.rawMaterialCostPerUnit = 0,
    this.laborCostPerMonth = 0,
    this.energyCostPerMonth = 0,
    this.packagingCostPerUnit = 0,
    this.otherOperationalCostPerMonth = 0,
    this.productionCapacityPerMonth = 0,
    this.sellingPricePerUnit = 0,
  });

  // Total CAPEX (Investasi Awal)
  double get totalCapex => machineCost + renovationCost + permitCost;

  // Total Variable Cost per Unit
  double get variableCostPerUnit => rawMaterialCostPerUnit + packagingCostPerUnit;

  // Total Fixed Cost per Month
  double get fixedCostPerMonth =>
      laborCostPerMonth + energyCostPerMonth + otherOperationalCostPerMonth;

  // Total Cost per Month (at full capacity)
  double get totalCostPerMonth =>
      fixedCostPerMonth + (variableCostPerUnit * productionCapacityPerMonth);

  // Revenue per Month (at full capacity)
  double get revenuePerMonth => sellingPricePerUnit * productionCapacityPerMonth;

  // Net Profit per Month
  double get netProfitPerMonth => revenuePerMonth - totalCostPerMonth;

  // Profit Margin (%)
  double get profitMargin =>
      revenuePerMonth == 0 ? 0 : (netProfitPerMonth / revenuePerMonth) * 100;

  // BEP (Break Even Point) in Units
  // Formula: Fixed Cost / (Price - Variable Cost)
  double get bepInUnits {
    double contributionMargin = sellingPricePerUnit - variableCostPerUnit;
    if (contributionMargin <= 0) return 0; // Loss or infinite BEP
    return fixedCostPerMonth / contributionMargin;
  }

  // BEP in Rupiah
  double get bepInRupiah => bepInUnits * sellingPricePerUnit;

  // ROI (Return on Investment) in Months (Simple Payback Period)
  // Formula: Total Capex / Net Profit per Month
  double get roiInMonths {
    if (netProfitPerMonth <= 0) return 0; // Never return investment if loss
    return totalCapex / netProfitPerMonth;
  }

  // ROI Percentage per Year
  double get roiPercentagePerYear {
    if (totalCapex == 0) return 0;
    return (netProfitPerMonth * 12 / totalCapex) * 100;
  }
}
