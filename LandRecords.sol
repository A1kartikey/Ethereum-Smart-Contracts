pragma solidity^0.4.19;

contract Land {
    
    
    struct land{
        
        address owner;
        bool isAvaliable;
        uint Id;
        uint prise;
        
    }
    
    mapping(uint => land) Lands;
    
    uint[] public landids;
    
    event landOwned(address Owner, uint landId, bool Avaliable);
    
    event Deal(address PreviousOwner, address NewOwner,  uint LandID,bool Availability);
    
    
    function AvaliableLand(uint Landid) constant public returns (bool){
        
        return (Lands[Landid].isAvaliable);
        
    }
    
    function AvaliableOwner(uint Landid)constant public returns (address){
        
        return Lands[Landid].owner;
        
    }
    
    
     function NewLand( address _owner,bool _isAvaliable,uint _Id) public  {
     
      Lands[_Id].owner = _owner;
      Lands[_Id].isAvaliable = _isAvaliable;
      Lands[_Id].Id = _Id;

      landids.push(_Id) + 1;
      
      emit landOwned (_owner,_Id,_isAvaliable);
    }    
    
    
    function SellLand(uint landId,address _owner, bool _isAvaliable ) payable public  returns (bool) {
    
    Lands[landId].owner = _owner;
    Lands[landId].isAvaliable = _isAvaliable;
        
    emit Deal(msg.sender,_owner,landId,_isAvaliable);
    return true;

    }
    
    
    
    function LandDetails(uint _landid) constant public returns (address,bool){
    
    return (Lands[_landid].owner,Lands[_landid].isAvaliable );   
        
    }
        
}
