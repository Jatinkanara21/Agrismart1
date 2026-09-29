from pathlib import Path
import pandas as pd, requests, joblib
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, classification_report
FEATURES=["N","P","K","temperature","humidity","ph","rainfall"]
def train_crop_model(url,output):
    csv=Path(output).parent.parent/"data"/"Crop_recommendation.csv"
    if not csv.exists():
        r=requests.get(url,timeout=60); r.raise_for_status(); csv.write_bytes(r.content)
    df=pd.read_csv(csv); df.columns=[c.strip() for c in df.columns]
    missing=[c for c in FEATURES+["label"] if c not in df.columns]
    if missing: raise ValueError(f"Crop dataset missing columns: {missing}")
    df=df.dropna(subset=FEATURES+["label"]).drop_duplicates()
    X,y=df[FEATURES],df["label"].astype(str)
    Xtr,Xte,ytr,yte=train_test_split(X,y,test_size=.2,random_state=42,stratify=y)
    model=RandomForestClassifier(n_estimators=300,random_state=42,n_jobs=-1,class_weight="balanced")
    model.fit(Xtr,ytr); pred=model.predict(Xte)
    print("crop_accuracy=",accuracy_score(yte,pred)); print(classification_report(yte,pred,zero_division=0))
    joblib.dump(model,output); return model
if __name__=="__main__":
    train_crop_model("https://raw.githubusercontent.com/the-amazing-atharva/Crop-Recommendation/main/Crop_recommendation.csv",Path(__file__).parent/"models"/"crop_model.joblib")
