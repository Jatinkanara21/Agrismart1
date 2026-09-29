from pathlib import Path
import joblib
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder

BASE = Path(__file__).resolve().parent
DATA = BASE / "data" / "crop_yield.csv"
MODEL = BASE / "models" / "yield_model.joblib"

FEATURES = [
    "Crop", "Crop_Year", "Season", "State", "Area",
    "Annual_Rainfall", "Fertilizer", "Pesticide"
]
TARGET = "Yield"


def train_yield_model(model_path: Path = MODEL) -> Path:
    if not DATA.exists():
        raise FileNotFoundError(
            f"Required bundled dataset is missing: {DATA}. "
            "The training pipeline never downloads data at runtime."
        )

    df = pd.read_csv(DATA)
    missing = [column for column in FEATURES + [TARGET] if column not in df.columns]
    if missing:
        raise ValueError(f"Yield dataset is missing columns: {missing}")

    df = df.dropna(subset=FEATURES + [TARGET]).drop_duplicates()
    if len(df) < 100:
        raise ValueError("Yield dataset must contain at least 100 usable rows.")

    X = df[FEATURES]
    y = pd.to_numeric(df[TARGET], errors="coerce")
    valid = y.notna()
    X, y = X.loc[valid], y.loc[valid]

    categorical = ["Crop", "Season", "State"]
    numeric = [c for c in FEATURES if c not in categorical]

    preprocessor = ColumnTransformer([
        ("categorical", OneHotEncoder(handle_unknown="ignore"), categorical),
        ("numeric", "passthrough", numeric),
    ])

    pipeline = Pipeline([
        ("preprocessor", preprocessor),
        ("regressor", RandomForestRegressor(
            n_estimators=300,
            random_state=42,
            n_jobs=-1,
        )),
    ])

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )
    pipeline.fit(X_train, y_train)

    predictions = pipeline.predict(X_test)
    mae = mean_absolute_error(y_test, predictions)
    rmse = mean_squared_error(y_test, predictions) ** 0.5
    r2 = r2_score(y_test, predictions)

    print(f"yield_mae={mae:.6f}")
    print(f"yield_rmse={rmse:.6f}")
    print(f"yield_r2={r2:.6f}")

    model_path.parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(pipeline, model_path)
    return model_path


if __name__ == "__main__":
    train_yield_model()
