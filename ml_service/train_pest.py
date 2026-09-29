from pathlib import Path
import joblib
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder

BASE = Path(__file__).resolve().parent
DATA = BASE / "data" / "pest_risk.csv"
DEFAULT_MODEL = BASE / "models" / "pest_model.joblib"

REQUIRED = ["crop","pest","temperature_c","humidity_pct","rainfall_mm","soil_moisture_pct","pest_count","etl","risk"]

def train_pest_model(model_path=DEFAULT_MODEL):
    if not DATA.exists():
        raise FileNotFoundError(f"Missing pest dataset: {DATA}")
    df = pd.read_csv(DATA)
    missing = [c for c in REQUIRED if c not in df.columns]
    if missing:
        raise ValueError(f"Missing columns: {missing}")
    df = df.dropna(subset=REQUIRED).drop_duplicates()
    if len(df) < 200 or df["risk"].nunique() < 3:
        raise ValueError("Pest dataset must contain at least 200 rows and three risk classes.")

    features = ["crop","pest","temperature_c","humidity_pct","rainfall_mm","soil_moisture_pct","pest_count","etl"]
    X, y = df[features], df["risk"].astype(str)
    cat = ["crop","pest"]
    num = [c for c in features if c not in cat]
    pre = ColumnTransformer([("cat", OneHotEncoder(handle_unknown="ignore"), cat)], remainder="passthrough")
    model = RandomForestClassifier(n_estimators=300, random_state=42, class_weight="balanced", n_jobs=-1)
    from sklearn.pipeline import Pipeline
    pipeline = Pipeline([("preprocess", pre), ("model", model)])
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
    pipeline.fit(X_train, y_train)
    pred = pipeline.predict(X_test)
    print(f"accuracy={accuracy_score(y_test, pred):.4f}")
    print(classification_report(y_test, pred, zero_division=0))
    model_path.parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(pipeline, model_path)
    return pipeline

if __name__ == "__main__":
    train_pest_model()
