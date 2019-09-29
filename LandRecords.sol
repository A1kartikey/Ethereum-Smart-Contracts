pragma solidity ^0.5.1;

contract Land {
    
    
    struct land{
        
        address owner;
        bool isAvaliable;
        uint Id;
        uint Prise;
        
    }
    
    address Registrar;
    
    constructor() public {
        
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
    
    
    function GetAlllandsIds() view public returns(uint[] memory){
        return(landids);
    }
    
    function isLandAvaliable(uint Landid) view public returns (bool){
        
        return (Lands[Landid].isAvaliable);
        
    }
    
    function WhoIsTheofOwner(uint Landid)view public returns (address){
        
        return Lands[Landid].owner;
        
    }
    
    function PriseOfLand(uint Landid)view public returns(uint){
        
        return Lands[Landid].Prise;
    }
    
    
     function NewLandRegistry( address _owner,bool _isAvaliable,uint _Id,uint _Prise) RegistrarOnly public  {
     
     for(uint i=0; i<=landids.length;i++){
         
         require(_Id != Lands[_Id].Id);
         
     }
     
      Lands[_Id].owner = _owner;
      Lands[_Id].isAvaliable = _isAvaliable;
      Lands[_Id].Id = _Id;
      Lands[_Id].Prise=_Prise;

      landids.push(_Id) + 1;
      
      emit landOwned (_owner,_Id,_isAvaliable,_Prise);
    }    
    
    
    function SetMyNewLandPrice(uint _id,uint NewPrise,bool currentStateOfLand)  public returns(bool,uint,bool){
        
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
    
    
    function LandDetails(uint _landid) view public returns (address,bool,uint){
    
    return (Lands[_landid].owner,Lands[_landid].isAvaliable,Lands[_landid].Prise );   
        
    }
        
}
