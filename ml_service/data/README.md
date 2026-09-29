# ML Dataset Provenance

## Fertilizer recommendation

fertilizer_recommendation.csv is a bundled, deduplicated subset of the public f2.csv dataset from:

- Repository: https://github.com/Tejasgolhar/Fertilizer_Recommendation_System
- Source file: f2.csv
- Source blob SHA observed during import: bc6e6c5bd2f13e18fb815f81dc6798f0f138b1b7

The source describes fertilizer recommendations using temperature, humidity, moisture, soil type, crop type, and N/P/K measurements.

This repository bundles the subset so production training does not depend on a runtime external download. The subset is intentionally documented as a subset; it is not represented as the complete upstream dataset.

Before using predictions for agronomic decisions, validate the model against locally collected, agronomist-reviewed field data for the target region and crops.
