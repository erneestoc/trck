enum TrckUnitSystem {
  case metric
  case royal
}

struct TrckSetup {
  let unitSystem:TrckUnitSystem = .metric
}
