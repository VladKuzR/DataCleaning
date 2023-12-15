# SQL Data Manipulation Script

## Description

This SQL script is designed for data manipulation in a database, specifically targeting a table named `NashvilleHousing` within the `portfolio_project` database. The script performs various operations to standardize data, populate missing address information, break down addresses into individual columns, change values in a specific field, remove duplicates, and delete unused columns.

## Usage

1. **Database Setup:**
   - Ensure you have the necessary database (`portfolio_project`) set up.
   - Execute the script in a SQL environment that has access to the target database.

2. **Run the Script:**
   - Copy and paste the script into your SQL environment.
   - Execute the script to perform the specified data manipulations.

## Database Schema

### Table: NashvilleHousing

- **Columns:**
  - `ParcelID`
  - `PropertyAddress`
  - `SaleDate`
  - ... (other columns)

- **Modified Columns:**
  - `PropertySplitAddress`
  - `PropertySplitCity`
  - `OwnerSplitAddress`
  - `OwnerSplitCity`
  - `OwnerSplitState`
  - `SoldAsVacant` (values changed to 'Yes' or 'No')

## Notes

- This script assumes the existence of a database named `portfolio_project` and a table named `NashvilleHousing`.
- Ensure that you have appropriate permissions to execute the script in your database environment.
- Review the script and adjust it based on your specific database schema and requirements.

## Author

Vladislav Kuznetsov

## Date

Last updated: 15-Dec-2023
