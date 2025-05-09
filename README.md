﻿# Smart-Contracts

# Infura API Integration for Ethereum Smart Contract Development

![Ethereum Infura Integration](https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white) 
![Infura](https://img.shields.io/badge/Infura-3C3C3D?style=for-the-badge&logo=ipfs&logoColor=white)

A complete guide to deploying and interacting with Ethereum smart contracts using Infura's API endpoints.

## Table of Contents
- [Prerequisites](#-prerequisites)
- [Setup](#-setup)
- [Configuration](#-configuration)
- [Deployment](#-deployment)
- [Interacting with Contracts](#-interacting-with-contracts)
- [Security](#-security)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)

## 📋 Prerequisites

Before you begin, ensure you have:

1. [Node.js](https://nodejs.org/) (v16+ recommended)
2. [Yarn](https://yarnpkg.com/) or npm
3. [MetaMask](https://metamask.io/) wallet with testnet ETH (get Sepolia ETH from [Alchemy Faucet](https://sepoliafaucet.com/))
4. [Infura account](https://infura.io/register) with Ethereum project created

## 🛠 Setup

### 1. Install Dependencies
```bash
npm install -g truffle
npm install @truffle/hdwallet-provider dotenv

# Infura API Integration for Ethereum Smart Contract Development

![Ethereum Infura Integration](https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white) 
![Infura](https://img.shields.io/badge/Infura-3C3C3D?style=for-the-badge&logo=ipfs&logoColor=white)

A complete guide to deploying and interacting with Ethereum smart contracts using Infura's API endpoints.

## Table of Contents
- [Prerequisites](#-prerequisites)
- [Setup](#-setup)
- [Configuration](#-configuration)
- [Deployment](#-deployment)
- [Interacting with Contracts](#-interacting-with-contracts)
- [Security](#-security)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)

## 📋 Prerequisites

Before you begin, ensure you have:

1. [Node.js](https://nodejs.org/) (v16+ recommended)
2. [Yarn](https://yarnpkg.com/) or npm
3. [MetaMask](https://metamask.io/) wallet with testnet ETH (get Sepolia ETH from [Alchemy Faucet](https://sepoliafaucet.com/))
4. [Infura account](https://infura.io/register) with Ethereum project created

## 🛠 Setup

### 2. Environment Configuration

Create .env file:
```bash
INFURA_API_KEY="your_project_id_from_infura"
MNEMONIC="your_metamask_12_word_recovery_phrase"

### Warning: Never commit your .env file! Add it to .gitignore:
```bash
echo ".env" >> .gitignore

⚙️ Configuration
Truffle Config (truffle-config.js)
```javascript
require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    sepolia: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC,
        `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`
      ),
      network_id: 11155111,
      gas: 5500000,
      gasPrice: 20000000000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
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

🚀 Deployment
### 1. Compile Contracts
```bash
truffle compile

### 2. Deploy to Sepolia Testnet
```bash
truffle migrate --network sepolia

### 3. Verify Deployment
``bash
truffle console --network sepolia
> const instance = await MyContract.deployed();
> console.log("Contract address:", instance.address);

🤖 Interacting with Contracts
Using Ethers.js
``javascript
const { ethers } = require("ethers");

const provider = new ethers.providers.InfuraProvider(
  "sepolia", 
  process.env.INFURA_API_KEY
);

const contract = new ethers.Contract(
  "0xYourContractAddress",
  ["function getValue() view returns (uint256)"],
  provider
);

async function readValue() {
  const value = await contract.getValue();
  console.log("Stored value:", value.toString());
}
readValue();

🔒 Security

* Never expose your MNEMONIC or API keys
* Use testnets for development
* Enable IP restrictions in Infura dashboard for production
* Consider using Truffle Dashboard for secure deployments

🐛 Troubleshooting

Error	                                                            Solution
Invalid API Key	                                            Verify project ID in Infura Dashboard
Insufficient Funds	                                        Get testnet ETH from faucet
ProviderError: execution reverted	                        Check contract revert reasons with truffle debug <txHash>


### Key Features:
1. **Complete Configuration**: Ready-to-use code snippets for Truffle and Ethers.js
2. **Security First**: Clear warnings about sensitive data handling
3. **Visual Elements**: Badges, tables, and code blocks for better readability
4. **Troubleshooting Guide**: Common errors and solutions
5. **Multi-environment Setup**: Includes both local (development) and testnet configurations




This project is licensed under the MIT License - see the LICENSE file for details.
