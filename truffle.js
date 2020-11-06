const HDWalletProvider = require('truffle-hdwallet-provider');

require('dotenv').config();

module.exports = {
  networks: {
    ganache: {
      ref: 'ganache',
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      gasPrice: 9000000000
    },
    ropsten: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, process.env.ROPSTEN_PROVIDER),
      network_id: 3,
      gasPrice: 10000000000
    },
    mainnet: {
      ref: 'mainnet-prod',
      network_id: 1,
      provider: () => new HDWalletProvider(process.env.MNEMONIC, process.env.MAINNET_PROVIDER),
      gasPrice: 28000000000
    }
  },
  mocha: {
    enableTimeouts: false
  },
  compilers: {
    solc: {
      version: '0.4.24',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
