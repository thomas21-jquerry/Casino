pragma solidity ^0.4.17;

contract Casino {
    address public manager;
    uint totalBalance;
    uint sumOfwinnersPool;
    address[] public winnerAddresses;
    address[] public players;
    uint[] public pool;
    uint[] public betNumber;
    
    function Casino() public {
        manager = msg.sender;
    }
    
    function enter(uint val) public payable returns(address[]) {
        require(msg.value > .01 ether);
        players.push(msg.sender);
        totalBalance+=msg.value;
        pool.push(msg.value);
        betNumber.push(val);
        if(players.length >= 100){
            pickWinners();
            delete players;
            delete pool;
            delete betNumber;
            return winnerAddresses;
        }
        
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now));
    }
    
    function pickWinners() private{
        uint winningNumber = random() % 10;
        for(uint i=0; i<players.length; i++){
            if(betNumber[i]==winningNumber){
                 sumOfwinnersPool += pool[i];
            }

        }
        for(uint j=0; j<players.length; j++){
            if(betNumber[j]==winningNumber){
                winnerAddresses.push(players[j]);
                players[j].transfer((pool[j]/sumOfwinnersPool) * 3 * this.balance / 5);
            }
        }
    }

    function getPlayers() public view returns (address[]) {
        return players;
    }

    function totalPool() public view returns (uint) {
        return totalBalance;
    }
    function getWinnerAddresses() public view returns (address[]) {
        return winnerAddresses;
    }
    
}   