module.exports = {
  networks: {
    // Local network (Ganache)
    development: {
      host: "127.0.0.1",  
      port: 7545,          
      network_id: "*",     
    },

    // Sepolia Network (opcional - só se for usar testnet)
    sepolia: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC,
        `https://sepolia.infura.io/v3/${process.env.INFURA_PROJECT_ID}`
      ),
      network_id: 11155111,
      gas: 5500000,
    }
  },
  compilers: {
    solc: {
      version: "0.8.21",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};