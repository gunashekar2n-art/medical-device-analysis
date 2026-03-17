import pandas as pd
import os

# Get project root (go one level up from scripts folder)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Build path to data file
file_path = os.path.join(BASE_DIR, "data", "medical_device_data.csv")

print("Loading file from:", file_path)

# Load dataset
df = pd.read_csv(file_path)

# Basic checks
print("\nFirst 5 rows:")
print(df.head())

print("\nDataset Info:")
print(df.info())

print("\nMissing Values:")
print(df.isnull().sum())

# Basic cleaning
df.drop_duplicates(inplace=True)
df.fillna("Unknown", inplace=True)

# Save cleaned data
output_path = os.path.join(BASE_DIR, "data", "cleaned_data.csv")
df.to_csv(output_path, index=False)

print("\n✅ Data cleaned and saved successfully!")