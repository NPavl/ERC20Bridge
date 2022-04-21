require('dotenv').config();
require("@nomiclabs/hardhat-waffle")
const {PRIVATE_KEY2, ALCHEMY_API_KEY, ETHERSCAN_API_KEY, COINMARKETCAP_API_KEY} = process.env
require("@nomiclabs/hardhat-etherscan")
//require('solidity-coverage')
//require("hardhat-gas-reporter");
//require('hardhat-contract-sizer');

// https://github.com/OpenZeppelin/workshops/blob/master/06-nft-merkle-drop/hardhat.config.js
const settings = {
  optimizer: {
    enabled: true,
    runs: 200,
  },
};

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await ethers.getSigners()

  for (const account of accounts) {
    console.log(account.address)
  }
  console.log("Account balance:", (await deployer.getBalance()).toString())
})

 module.exports = {
  solidity: {
  compilers: [
      { version: '0.8.4',  settings },
      // { version: '0.7.6',  settings },
      // { version: '0.6.12', settings },
      // { version: '0.5.16', settings },
  ], },
  networks: {
    rinkiby: {
      url: `https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [`${PRIVATE_KEY2}`], // [`0x${PRIVATE_KEY}`]
      network_id: 4
    },  
    // ropsten: {
    //   url: `https://ropsten.infura.io/v3/${INFURA_API_KEY}`,
    //   accounts: [`0x${PRIVATE_KEY}`],
    //   network_id: 3
    // },   
    // hardhat: {
    //   forking: {  // https://hardhat.org/hardhat-network/
    //     url: `https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
    //     blockNumber: 12883802
    //   } // https://hardhat.org/hardhat-network/guides/mainnet-forking.html
    // },
    // bcs_test: {
    //   url: `https://mainnet.infura.io/v3/${ALCHEMY_API_KEY}`,
    //   accounts: [`0x${PRIVATE_KEY}`],
    //   network_id: 97
    // }
  }, 
  // gasReporter: { 
  //   currency: "USD",
  //   coinmarketcap: COINMARKETCAP_API_KEY || null, // process.env.COINMARKETCAP_API_KEY
  // },
  // gasReporter: { 
  //   enabled: process.env.REPORT_GAS ? true : false, 
  //   currency: "ETH", 
  //   // gasPrice: 21, 
  //   coinmarketcap: COINMARKETCAP_API_KEY
  // },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  }
}
 