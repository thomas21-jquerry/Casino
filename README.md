# Casino
This repository contains ethereum smart contract for a casino where you can enter a betting by pooling in ether and pick a number to bet on. After 100 successful new entries the contract automatically picks a random winning number and those who have made a successful bet will get a portion of the pool based on the amount initailly they bet with.

<br/>
code for casino smart contract can be found

[here](https://github.com/thomas21-jquerry/Casino/blob/main/contracts/Casino.sol)

## Tech Used
- Solidity
- javasript
- node 
- mocha
- web3
- ganache

## How to get started
- git clone this repository ``` git clone https://github.com/thomas21-jquerry/Casino.git ```

- install all dependdencies ```npm install```

- run test  ```npm run test```


## Working 
- player enters the bet by betting on a number between 0 and 9 with any amount of ether 
- After 100 players entered the contract automatically picks winners based on a random number generated between 1 and 10
- The players who have betted successfully will recieve the percentage of ether he/she contributed
- All the states will be cleared after the contract picks the winners 
- All the winners accound address could be found after calling getWinnerAddresses in the smart contract
