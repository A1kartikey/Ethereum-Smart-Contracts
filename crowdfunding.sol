pragma solidity ^0.4.19;

contract CrowdFunding {

    
    struct Fund {
        
        address owner;
        
        string desc;
        
        uint goal;

        
        uint coins;
        
        bool finished;

        
        uint recordCounts;
        
        mapping(uint => Record) records;
    }

    
    struct Record {
        
        address member;
        
        uint coin;
        
        uint time;
    }

    
    Fund[]  funds;

    
    function getFundCount() public view returns (uint) {
        return funds.length;
    }

    function getFundInfo(uint fundIndex) public view returns (address, string, uint, uint, bool) {
        Fund storage fund = funds[fundIndex];
        return (fund.owner, fund.desc, fund.goal, fund.coins, fund.finished);
    }

    
    function getRecordCount(uint fundIndex) public view returns (uint) {
        return funds[fundIndex].recordCounts;
    }

    function getRecordInfo(uint fundIndex, uint recordIndex) public view returns (address, uint, uint) {
        Record storage record = funds[fundIndex].records[recordIndex];
        return (record.member, record.coin, record.time);
    }

    function raiseFund(string info, uint goal) public {
        funds.push(Fund(msg.sender, info, goal, 0, false, 0));
    }

    function sendCoin(uint fundIndex) public payable {
        Fund storage fund = funds[fundIndex];
        require(!fund.finished);

        fund.owner.transfer(msg.value);
        fund.coins += msg.value;
        fund.records[fund.recordCounts++] = Record(msg.sender, msg.value, now);
        fund.finished = fund.coins >= fund.goal * 1 wei ? true : false;
    }

    function() public payable { }
}
