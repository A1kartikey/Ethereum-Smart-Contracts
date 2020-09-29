pragma solidity^0.5.5;

contract VoteSystem{

 struct candidate {
     uint voterId;
     string name;
     uint age;
     uint voteCount;
 }
 
 mapping (uint => candidate) candidateMap;
 
 struct voters {
     uint voterId;
     string name;
     uint age;
     bool votingState;
 }

 mapping (uint => voters) votersMap;
 
 modifier checkVoterVoted(uint _votersVoterId){
     require (votersMap[_votersVoterId].votingState == false);
     _;
 }


uint[] voterIdlist;
uint[] candidateIdList;


 function enrollCandidate(uint _voterId,string memory _name,uint  _age )  public {

 require (_age >= 25); 
 require (candidateMap[_voterId].voterId != _voterId);

    candidateMap[_voterId].voterId = _voterId;
    candidateMap[_voterId].name = _name;
    candidateMap[_voterId].age = _age;
    
    candidateIdList.push(_voterId);
 } 

 function enrollVoter(uint _voterId,string memory _name,uint _age)  public {

require (_age >= 18);
require (votersMap[_voterId].voterId != _voterId);

     votersMap[_voterId].voterId = _voterId;
     votersMap[_voterId].name = _name;
     votersMap[_voterId].age = _age;
     
     voterIdlist.push(_voterId);
 }
 
 function getCandidateDetails(uint _voterId) view public returns(uint,string memory,uint,uint) {

     return (candidateMap[_voterId].voterId,candidateMap[_voterId].name,candidateMap[_voterId].age,candidateMap[_voterId].voteCount);
 }
 
 function getVoterDetails(uint _voterId) view public returns (uint,string memory,uint,bool){
     
     return (votersMap[_voterId].voterId,votersMap[_voterId].name,votersMap[_voterId].age,votersMap[_voterId].votingState);
     
 }
 
 function vote(uint _candidateVoterId,uint _votersVoterId) public checkVoterVoted(_votersVoterId) {
     candidateMap[_candidateVoterId].voteCount += 1;
     votersMap[_votersVoterId].votingState = true;
 }
 
 function getVotecountOf(uint _voterId) view public returns(uint){
     return candidateMap[_voterId].voteCount;
 }
 
 function getVoterList() view public returns (uint[] memory){

    return   voterIdlist;  
    }
    
 function getCandidateList() view public returns(uint[] memory){
     
 
 return candidateIdList;    
 }   

    
}

