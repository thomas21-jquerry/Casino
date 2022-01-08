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
        if(players.length >= 100){      // if size of players is equal to 100 then picks a winner and resets all the states
            pickWinners();            
            delete players;
            delete pool;
            delete betNumber;
            return winnerAddresses;
        }
        
    }
    
    function random() private view returns (uint) {   // generate random number
        return uint(keccak256(block.difficulty, now));
    }
    
    function pickWinners() private{             // picks players who won the bet
        uint winningNumber = random() % 10;    // make the scope of random number between 0 and 9
        for(uint i=0; i<players.length; i++){
            if(betNumber[i]==winningNumber){
                 sumOfwinnersPool += pool[i];
            }

        }
        for(uint j=0; j<players.length; j++){
            if(betNumber[j]==winningNumber){
                winnerAddresses.push(players[j]);
                players[j].transfer((pool[j]/sumOfwinnersPool) * 3 * this.balance / 5);       // send price based on percentage of money collected from players
            }
        }
    }

    function getPlayers() public view returns (address[]) {   // returns the list of players who have entered
        return players;
    }

    function totalPool() public view returns (uint) {    // returns the total pool at that moment
        return totalBalance;
    }
    function getWinnerAddresses() public view returns (address[]) {   // returns addresses of winners
        return winnerAddresses;
    }
    
}   
