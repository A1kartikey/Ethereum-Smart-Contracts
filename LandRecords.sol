pragma solidity ^0.5.1;

contract Land {
    
    
    struct land{
        
        address owner;
        bool isAvaliable;
        uint SurveyId;
        uint Prise;
        
    }
    
    address Registrar;
    
    constructor() public {
        
        Registrar = msg.sender;
    }
    
    mapping(uint => land) Lands;
    
    uint[] public SurveyIds;
    
    
    modifier RegistrarOnly(){
    
        Registrar == msg.sender;
        
        _;
    }
    
    event landOwned(address Owner, uint landId, bool Avaliable,uint prise);
    
    event Deal(address PreviousOwner, address NewOwner,  uint LandID,bool Availability,uint prise);
    
    
    function GetAlllandsIds() view public returns(uint[] memory){
        return(SurveyIds);
    }
    
    function isLandAvaliable(uint SurveyId) view public returns (bool){
        
        return (Lands[SurveyId].isAvaliable);
        
    }
    
    function WhoIsTheofOwner(uint SurveyId)view public returns (address){
        
        return Lands[SurveyId].owner;
        
    }
    
    function PriseOfLand(uint SurveyId)view public returns(uint){
        
        return Lands[SurveyId].Prise;
    }
    
    
     function NewLandRegistry( address _owner,bool _isAvaliable,uint _SurveyId,uint _Prise) RegistrarOnly public  {
     
     for(uint i=0; i<=SurveyIds.length;i++){
         
         require(_SurveyId != Lands[_SurveyId].SurveyId);
         
     }
     
      Lands[_SurveyId].owner = _owner;
      Lands[_SurveyId].isAvaliable = _isAvaliable;
      Lands[_SurveyId].SurveyId = _SurveyId;
      Lands[_SurveyId].Prise=_Prise;

      SurveyIds.push(_SurveyId) + 1;
      
      emit landOwned (_owner,_SurveyId,_isAvaliable,_Prise);
    }    
    
    
    function SetMyNewLandPrice(uint _SurveyId,uint NewPrise,bool currentStateOfLand)  public returns(bool,uint,bool){
        
        require(Lands[_SurveyId].owner == msg.sender);
        Lands[_SurveyId].Prise = NewPrise;
        Lands[_SurveyId].isAvaliable = currentStateOfLand;
        
        return(true,Lands[_SurveyId].Prise,Lands[_SurveyId].isAvaliable);
    }
    
    function SellLand(uint _SurveyId,address _owner, bool _isAvaliable, uint PayingPrise ) payable public  returns (bool) {
    
    require(Lands[_SurveyId].owner == msg.sender && Lands[_SurveyId].Prise <= PayingPrise && Lands[_SurveyId].isAvaliable == true);
    
    Lands[_SurveyId].owner = _owner;
    Lands[_SurveyId].isAvaliable = _isAvaliable;
    Lands[_SurveyId].Prise = PayingPrise;    

    emit Deal(msg.sender,_owner,_SurveyId,_isAvaliable,PayingPrise);
    return true;

    }
    
    
    function LandDetails(uint _SurveyId) view public returns (address,bool,uint){
    
    return (Lands[_SurveyId].owner,Lands[_SurveyId].isAvaliable,Lands[_SurveyId].Prise );   
        
    }
        
}
