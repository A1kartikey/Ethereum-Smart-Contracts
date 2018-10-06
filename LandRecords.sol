pragma solidity ^0.4.19;

contract Land {
    
    
    struct land{
        
        address owner;
        bool isAvaliable;
        uint Id;
        uint Prise;
        
    }
    
    address Registrar;
    
    constructor(){
        
        Registrar = msg.sender;
    }
    
    mapping(uint => land) Lands;
    
    uint[] public landids;
    
    
    modifier RegistrarOnly(){
    
        Registrar == msg.sender;
        
        _;
    }
    
    event landOwned(address Owner, uint landId, bool Avaliable,uint prise);
    
    event Deal(address PreviousOwner, address NewOwner,  uint LandID,bool Availability,uint prise);
    
    
    function GetAlllandsIds() constant public returns(uint[]){
        return(landids);
    }
    
    function isLandAvaliable(uint Landid) constant public returns (bool){
        
        return (Lands[Landid].isAvaliable);
        
    }
    
    function WhoIsTheofOwner(uint Landid)constant public returns (address){
        
        return Lands[Landid].owner;
        
    }
    
    function PriseOfLand(uint Landid)constant public returns(uint){
        
        return Lands[Landid].Prise;
    }
    
    
     function NewLandRegistry( address _owner,bool _isAvaliable,uint _Id,uint _Prise) RegistrarOnly public  {
     
     for(uint i=0; i<=landids.length;i++){
         
         if(_Id == Lands[_Id].Id)
         throw;
     }
     
      Lands[_Id].owner = _owner;
      Lands[_Id].isAvaliable = _isAvaliable;
      Lands[_Id].Id = _Id;
      Lands[_Id].Prise=_Prise;

      landids.push(_Id) + 1;
      
      emit landOwned (_owner,_Id,_isAvaliable,_Prise);
    }    
    
    
    function SetMyNewLandPrice(uint _id,uint NewPrise,bool currentStateOfLand) constant public returns(bool,uint,bool){
        
        require(Lands[_id].owner == msg.sender);
        Lands[_id].Prise = NewPrise;
        Lands[_id].isAvaliable = currentStateOfLand;
        
        return(true,Lands[_id].Prise,Lands[_id].isAvaliable);
    }
    
    function SellLand(uint landId,address _owner, bool _isAvaliable, uint PayingPrise ) payable public  returns (bool) {
    
    require(Lands[landId].owner == msg.sender && Lands[landId].Prise <= PayingPrise && Lands[landId].isAvaliable == true);
    
    Lands[landId].owner = _owner;
    Lands[landId].isAvaliable = _isAvaliable;
    Lands[landId].Prise = PayingPrise;    

    emit Deal(msg.sender,_owner,landId,_isAvaliable,PayingPrise);
    return true;

    }
    
    
    function LandDetails(uint _landid) constant public returns (address,bool,uint){
    
    return (Lands[_landid].owner,Lands[_landid].isAvaliable,Lands[_landid].Prise );   
        
    }
        
}
