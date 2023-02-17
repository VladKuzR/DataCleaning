USE portfolio_project;


-- Standartize Date Format
SELECT *
FROM   NashvilleHousing;

SELECT SaleDate,
       CONVERT (DATE, SaleDate)
FROM   NashvilleHousing;

UPDATE NashvilleHousing
SET    SaleDate = CONVERT (DATE, SaleDate);

ALTER TABLE NashvilleHousing
  ALTER COLUMN SaleDate DATE;

--Populate Property Address Data
SELECT *
FROM   NashvilleHousing
--where PropertyAddress is null
ORDER  BY ParcelID;

SELECT a.ParcelID,
       a.PropertyAddress,
       b.ParcelID,
       b.PropertyAddress,
       Isnull(a.PropertyAddress, b.PropertyAddress)
FROM   NashvilleHousing AS a
       JOIN NashvilleHousing AS b
         ON a.ParcelID = b.ParcelID
            AND a.[UniqueID] <> b.[UniqueID]
WHERE  a.PropertyAddress IS NULL;

UPDATE a
SET    PropertyAddress = Isnull(a.PropertyAddress, b.PropertyAddress)
FROM   NashvilleHousing AS a
       JOIN NashvilleHousing AS b
         ON a.ParcelID = b.ParcelID
            AND a.[UniqueID] <> b.[UniqueID]
WHERE  a.PropertyAddress IS NULL;

--Breaking out Address into Individual Columns (Address, City, State)
SELECT PropertyAddress
FROM   NashvilleHousing

--where PropertyAddress is null
--order by ParcelID;
SELECT Substring(PropertyAddress, 1, Charindex(',', PropertyAddress) - 1) AS
       Address,
       Substring(PropertyAddress, Charindex(',', PropertyAddress) + 1, Len(
       PropertyAddress))                                                  AS
       City
FROM   NashvilleHousing;

ALTER TABLE NashvilleHousing
  ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET    PropertySplitAddress = Substring(PropertyAddress, 1,
                                     Charindex(',', PropertyAddress) - 1);

ALTER TABLE NashvilleHousing
  ADD PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET    PropertySplitCity = Substring(PropertyAddress,
                           Charindex(',', PropertyAddress) +
                                  1, Len(
                           PropertyAddress));

SELECT *
FROM   NashvilleHousing;

SELECT Parsename(Replace (OwnerAddress, ',', '.'), 3),
       Parsename(Replace (OwnerAddress, ',', '.'), 2),
       Parsename(Replace (OwnerAddress, ',', '.'), 1)
FROM   NashvilleHousing;

ALTER TABLE NashvilleHousing
  ADD OwnerSplitAddress NVARCHAR(255), ownersplitcity NVARCHAR(255),
  OwnerSplitState NVARCHAR(255);

UPDATE NashvilleHousing
SET    OwnerSplitAddress = Parsename(Replace (OwnerAddress, ',', '.'), 3),
       ownersplitcity = Parsename(Replace (OwnerAddress, ',', '.'), 2),
       OwnerSplitState = Parsename(Replace (OwnerAddress, ',', '.'), 1);

SELECT *
FROM   NashvilleHousing;

--Change Y and N to Yes and No in "Sold as Vacant" field
SELECT DISTINCT SoldAsVacant,
                Count(SoldAsVacant)
FROM   NashvilleHousing
GROUP  BY SoldAsVacant
ORDER  BY 2;

SELECT SoldAsVacant,
       CASE
         WHEN SoldAsVacant = 'Y' THEN 'Yes'
         WHEN SoldAsVacant = 'N' THEN 'No'
         ELSE SoldAsVacant
       END
FROM   NashvilleHousing;

UPDATE NashvilleHousing
SET    SoldAsVacant = CASE
                        WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                      END;

--Remove Duplicates
WITH RowNumCTE
     AS (SELECT *,
                Row_number()
                  OVER (
                    partition BY ParcelID, PropertyAddress, saleprice, SaleDate,
                  legalreference
                    ORDER BY uniqueid) row_num
         FROM   NashvilleHousing)
--order by ParcelID);
SELECT *
FROM   RowNumCTE
WHERE  row_num > 1;

--Delete Unused Columns
SELECT *
FROM   NashvilleHousing;

ALTER TABLE NashvilleHousing
  DROP COLUMN OwnerAddress, taxdistrict, PropertyAddress;

ALTER TABLE NashvilleHousing
  DROP COLUMN SaleDate; 