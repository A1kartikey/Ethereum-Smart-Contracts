pragma solidity ^0.5.1;

contract MedicineTraciblity{
    
    struct Medicine{
        uint MedicineId;       
        string MedicineName;    
        uint ManufacturerId;
        uint DistributerId;
        uint RetailerId;     
        string ManfacturerDate;
        string ExpairyDate;
        
        uint InHandOff; //Medicines currently With Whome
    
    }
    
    
    struct Manufacturer{ 
        uint    ManufacturerId;
        string  ManufacturerName;
        string  ManufacturerLocation;
        uint [] MedicinesManufactured;
                
    }
    
    struct Distributer { 
        uint    DistributerId;
        string  DistributerName;
        string  DistributerLocation;
        uint [] MedicinesManufactured ;
                
    }
    
    struct Retailer{ 
        uint    RetailerId;
        string  RetailerName;
        string  RetailerLocation;
        uint[]  MedicinesManufactured;
            
    }
    
    mapping(uint=>Medicine)MedicineMap;
    mapping(uint=>Manufacturer)ManufacturerMap;
    mapping(uint =>Distributer)DistributerMap;
    mapping(uint =>Retailer)RetailerMap;
    
    uint[] Medicines;
    uint[] ManufacturerList;
    uint[] DistributerList;
    uint[] RetailerList;
    

function ManufacturerDetails(uint _ManufacturerId,string memory _ManufacturerName,string memory _ManufacturerLocation)public{
    require(ManufacturerMap[_ManufacturerId].ManufacturerId != _ManufacturerId);
    ManufacturerMap[_ManufacturerId].ManufacturerId=_ManufacturerId;
    ManufacturerMap[_ManufacturerId].ManufacturerName=_ManufacturerName;
    ManufacturerMap[_ManufacturerId].ManufacturerLocation=_ManufacturerLocation;
    ManufacturerList.push(_ManufacturerId);
          
}

  function DistributerDetails( uint _DistributerId , string memory _DistributerName,string memory _DistributerLocation)public{
     require(DistributerMap[_DistributerId].DistributerId != _DistributerId);
     DistributerMap[_DistributerId].DistributerId=_DistributerId;
     DistributerMap[_DistributerId].DistributerName=_DistributerName;
     DistributerMap[_DistributerId].DistributerLocation=_DistributerLocation;

      DistributerList.push(_DistributerId);
  } 



  function RetailerDetails(uint _RetailerId,string memory _RetailerName,string memory _RetailerLocation)public{
     require(RetailerMap[_RetailerId].RetailerId != _RetailerId);
     RetailerMap[_RetailerId].RetailerId=_RetailerId;
     RetailerMap[_RetailerId].RetailerName=_RetailerName;
     RetailerMap[_RetailerId].RetailerLocation=_RetailerLocation;

      RetailerList.push(_RetailerId);
  }


    
function MoveToManufacturer (uint _MedicineId, string memory _MedicineName,string memory _ExpairyDate,string memory _ManfacturerDate,uint _ManufacturerId)public{

    require(MedicineMap[_MedicineId].MedicineId != _MedicineId);
    MedicineMap[_MedicineId].MedicineId= _MedicineId;
    MedicineMap[_MedicineId].MedicineName = _MedicineName;
    MedicineMap[_MedicineId].ExpairyDate = _ExpairyDate;
    MedicineMap[_MedicineId].ManfacturerDate = _ManfacturerDate;
    MedicineMap[_MedicineId].ManufacturerId=_ManufacturerId;
    MedicineMap[_MedicineId].InHandOff = _ManufacturerId;
    ManufacturerMap[_ManufacturerId].MedicinesManufactured.push(_MedicineId); 
    Medicines.push(_MedicineId);
}

function MoveToDistributer (uint _MedicineId , uint _DistributerId  ) public {
     
    
     MedicineMap[_MedicineId].InHandOff = _DistributerId;
     MedicineMap[_MedicineId].DistributerId = _DistributerId;
     DistributerMap[_DistributerId].MedicinesManufactured.push(_MedicineId);
     
 }
 
function MoveToRetailer (uint _MedicineId ,uint _RetailerId ) public {
    MedicineMap[_MedicineId].InHandOff = _RetailerId;
    MedicineMap[_MedicineId].RetailerId = _RetailerId;
    RetailerMap[_RetailerId].MedicinesManufactured.push(_MedicineId);
}



function GetMedicineDetails ( uint _MedicineId) view public returns (uint , string memory,uint, uint,uint,string memory,string memory  ){
    return ( MedicineMap[_MedicineId].MedicineId,   MedicineMap[_MedicineId].MedicineName ,  MedicineMap[_MedicineId].ManufacturerId, MedicineMap[_MedicineId].DistributerId,MedicineMap[_MedicineId].RetailerId,MedicineMap[_MedicineId].ExpairyDate,MedicineMap[_MedicineId].ManfacturerDate );
}
 
  
 function GetManufacturerDetails(uint _ManufacturerId) view public returns(uint,string memory,string memory){
     return(ManufacturerMap[_ManufacturerId].ManufacturerId, ManufacturerMap[_ManufacturerId].ManufacturerName, ManufacturerMap[_ManufacturerId].ManufacturerLocation);
 } 

 function GetDistributerDetails(uint _DistributerId) view public returns(uint,string memory,string memory){
     return(DistributerMap[_DistributerId].DistributerId, DistributerMap[_DistributerId].DistributerName, DistributerMap[_DistributerId].DistributerLocation);
 }
                
  
 function GetRetailerDetails (uint _RetailerId) view public returns(uint,string memory,string memory){
     return(RetailerMap[_RetailerId].RetailerId, RetailerMap[_RetailerId].RetailerName, RetailerMap[_RetailerId].RetailerLocation);
 }
                

function GetInHandoff (uint _MedicineId) view public returns( uint ){
  return (MedicineMap[_MedicineId].InHandOff);
    } 
    
function GetAllMedicines() view public returns (uint[] memory){
    return Medicines;
}

function GetAllManufacturer() view public returns(uint[] memory){
    return ManufacturerList;
}

function GetAllRetailer() view public returns(uint[] memory){
    return RetailerList;
    }     
    
function GetAllDistributer() view public returns(uint[] memory){
    return DistributerList;
}    
    
}
