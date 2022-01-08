const assert = require('assert');
const ganache = require('ganache-cli')
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());

const {interface, bytecode } = require('../compile');

let casino;
let accounts;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
    // console.log(web3.eth.getBalance(accounts[0]));

    casino = await new web3.eth.Contract(JSON.parse(interface)).deploy({ data: bytecode }).send({ from: accounts[0],gas: '1000000' })
});

describe('Casino Contract', ()=>{
    it('deploys a contract', ()=>{
        assert.ok(casino.options.address);
    });


    it('allows one account to enter', async () => {
        await casino.methods.enter(2).send({
            from: accounts[1],
            value: web3.utils.toWei('2', 'ether'),
            gas: '1000000'
        });

        const players = await casino.methods.getPlayers().call({
            from: accounts[1]
        });
        const totalBalance = await casino.methods.totalPool().call({
            from: accounts[1]
        });
        
        assert.equal(2000000000000000000,totalBalance)
        assert.equal(accounts[1],players[0]);
        assert.equal(1,players.length);
    });

    it("allows multiple accounts to enter", async () => {
       for(i=0;i<101;i++){
           await casino.methods.enter(i%10).send({
               from:accounts[i%5],
               value: web3.utils.toWei("1","ether"),
               gas: '1000000'
           });

       }
       let winnerAddress = await casino.methods.getWinnerAddresses().call({
           from: accounts[1]
       });
       assert.greaterorequal(winnerAddress.length,0);

      });
});