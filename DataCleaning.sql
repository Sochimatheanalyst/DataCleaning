Select *
From PortfolioProject1..NashvilleHousing


--im tryna seperate the owners address into street address,city and state
Select OwnerAddress,

--so i replaced the current delimiter which is a comma with a period which is the primary delimiter the parsename function recognizesr
Parsename(replace(owneraddress,',','.'), 3) Street,
Parsename(replace(owneraddress,',','.'), 2) city,
Parsename(replace(owneraddress,',','.'), 1) State

From PortfolioProject1.dbo.NashvilleHousing 

--this adds a new column for street
alter table PortfolioProject1.dbo.NashvilleHousing 
add OwnerAddressStreet nvarchar(100);

--This fills that column with street data
update PortfolioProject1..NashvilleHousing
set OwnerAddressStreet = Parsename(replace(owneraddress,',','.'), 3)

--this adds a new column for city
alter table PortfolioProject1.dbo.NashvilleHousing 
add OwnerAddressCity nvarchar(100);

--This fills that column with city data
update PortfolioProject1..NashvilleHousing
set OwnerAddressCity = Parsename(replace(owneraddress,',','.'), 2)

--this adds a new column for state
alter table PortfolioProject1.dbo.NashvilleHousing 
add OwnerAddressState nvarchar(100);

--This fills that column with state data
update PortfolioProject1..NashvilleHousing
set OwnerAddressState = Parsename(replace(owneraddress,',','.'), 1)

--i wanna try something with the soldasvacant field

--looking at all the distict contents of the SoldAsVacant field
Select distinct(SoldAsVacant)
from PortfolioProject1..NashvilleHousing


Select SoldAsVacant,
Case
	when SoldAsVacant = 'y' then 'Yes'
	when SoldAsVacant = 'n' then 'No'
	else SoldAsVacant
end
from PortfolioProject1..NashvilleHousing


alter table PortfolioProject1.dbo.NashvilleHousing 
add SoldAsVacantEdited nvarchar(100);

--This fills that column with this data
update PortfolioProject1..NashvilleHousing
set SoldAsVacantEdited = 
Case
	when SoldAsVacant = 'y' then 'Yes'
	when SoldAsVacant = 'n' then 'No'
	else SoldAsVacant
end


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject1.dbo.NashvilleHousing
--order by ParcelID
)
SELECT *
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress


--deleting columns that are not necessary

Select *
From PortfolioProject1.dbo.NashvilleHousing


ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate












