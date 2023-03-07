SELECT *
FROM PortfolioProject..[Nashville Housing]

-- Standardize Date Format

SELECT SaleDateConverted, CONVERT(Date, SaleDate)
FROM PortfolioProject..[Nashville Housing]

UPDATE [Nashville Housing]
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE [Nashville Housing]
ADD SaleDateConverted Date;

UPDATE [Nashville Housing]
SET SaleDateConverted = CONVERT(Date, SaleDate)

-- Populate Property Address

SELECT * 
FROM PortfolioProject..[Nashville Housing]
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..[Nashville Housing] a
JOIN PortfolioProject..[Nashville Housing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..[Nashville Housing] a
JOIN PortfolioProject..[Nashville Housing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

-- Breaking out Address into Individual Columns (Address, City, State)

SELECT PropertyAddress
FROM PortfolioProject..[Nashville Housing]
--WHERE PropertyAddress IS NULL
--ORDER BY ParcelID

-- Separating Property Address with SUBSTRING with ',' as Delimiter

SELECT 
SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS City
FROM PortfolioProject..[Nashville Housing]

ALTER TABLE [Nashville Housing]
ADD PropertySplitAddress NVARCHAR(255);

UPDATE [Nashville Housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE [Nashville Housing]
ADD PropertySplitCity NVARCHAR(255);

UPDATE [Nashville Housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

-- Separating OwnerAddress with PARSENAME

SELECT OwnerAddress
FROM [Nashville Housing]

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS Address,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS City,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS State
FROM [Nashville Housing]


ALTER TABLE [Nashville Housing]
ADD OwnerSplitAddress NVARCHAR(255);

UPDATE [Nashville Housing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) 

ALTER TABLE [Nashville Housing]
ADD OwnerSplitCity NVARCHAR(255);

UPDATE [Nashville Housing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) 

ALTER TABLE [Nashville Housing]
ADD OwnerSplitState NVARCHAR(255);

UPDATE [Nashville Housing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) 

-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject..[Nashville Housing]
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant, 
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant 
	END
FROM PortfolioProject..[Nashville Housing]

UPDATE PortfolioProject..[Nashville Housing]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant 
	END

--Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID, 
				 PropertyAddress, 
				 SalePrice, 
				 SaleDate, 
				 LegalReference
					 ORDER BY UniqueID
) Row_num
FROM PortfolioProject..[Nashville Housing]
--ORDER BY ParcelID
)
SELECT *
FROM RowNumCTE
WHERE Row_num > 1
--ORDER BY PropertyAddress

-- Delete Unused Columns

SELECT *
FROM PortfolioProject..[Nashville Housing]

ALTER TABLE PortfolioProject..[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject..[Nashville Housing]
DROP COLUMN SaleDate
