# Yield Dataset Provenance

This bundled dataset is **synthetic and formula-generated for development and CI validation**. It is not a collection of government or farmer field measurements.

The schema follows the crop-yield feature structure used by the AgriSmart yield training pipeline:
Crop, Crop_Year, Season, State, Area, Annual_Rainfall, Fertilizer, Pesticide, Yield.

The values are generated deterministically from crop-specific baseline yields and bounded environmental/input factors. They are intended to verify preprocessing, categorical encoding, model training, serialization, API inference, and CI.

**Do not interpret model metrics or predictions trained on this dataset as agricultural evidence.** Before production use, replace this file with a licensed, validated real-world yield dataset and re-evaluate the model.

A real-world Indian crop-yield dataset with a similar schema is documented at:
https://github.com/Aswins10/Agricultural-Crop-Yield-in-Indian-States-Dataset

That external dataset is not copied into this repository because its redistribution/license terms have not been independently verified here.
