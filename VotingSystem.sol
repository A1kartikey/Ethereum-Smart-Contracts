pragma solidity ^0.8.9 ;

contract election {

        struct candidate {
            uint Id ;
            string Name ;
            uint totalVoteCount ;
        }

        struct voter {
            uint Id ;
            string Name  ; 
            bool Voted ;
            uint age ;
        }

        mapping (uint => voter )   votersMap ;
        mapping (uint => candidate) candidateMap ;

        uint[] votercount ;

        function enrollCandidate(uint _id , string memory _name) public {

            require(candidateMap[_id].Id  != _id ) ;
            candidateMap[_id].Id = _id ;
            candidateMap[_id].Name = _name ; 
            candidateMap[_id].totalVoteCount = 0 ;
        } 

        function getCandidateDetails(uint _id) view public returns(uint,string memory,uint){
            
            return (candidateMap[_id].Id,
                    candidateMap[_id].Name,
                    candidateMap[_id].totalVoteCount) ;

        }

        function enrollVoter(uint _id , uint _age , string memory _name) public {
            require(votersMap[_id].Id  != _id , "Id alredy Exists ! ") ;
            require(_age >= 18 ,"Your Age is below 18. " ) ;
            votersMap[_id].Id = _id ;
            votersMap[_id].Name = _name ; 
            votersMap[_id].Voted = false;
            votersMap[_id].age = _age ; 

            votercount.push(_id) ;
        } 

    function getVoterDetails(uint _id) view public returns(uint,string memory,bool){
            
            return (votersMap[_id].Id,
                    votersMap[_id].Name,
                    votersMap[_id].Voted) ;

        }

        function vote(uint _candidateId , uint _voterId) public {

            candidateMap[_candidateId].totalVoteCount++ ;
            votersMap[_voterId].Voted = true ;

        }

        function getAllVoterIds() view public returns (uint[] memory) {

            return votercount ; 
        }

        function getAllVoterIdsCount() view public returns (uint) {

            return votercount.length ; 
        }
}

